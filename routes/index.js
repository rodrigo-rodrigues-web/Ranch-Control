var express = require('express');
// const { disabled } = require('../app');
var router = express.Router();
let audits;
let alert;
/* GET home page. */
router.get('/', async function(req, res, next) {
  alert = {display:"display:none", message:"The audit name already exist. Enter a unique name."}
  audits = await global.db.getAudits();
  res.render('index', { appName: 'Ranch Control', title: 'Manage Audit', audits, alert, hidden:'' });
});

router.get('/newaudit', async function(req, res, next) {
  res.redirect('/');
});

router.post('/newaudit', async function(req, res){

  const auditName = req.body.auditName
  const auditExist = await global.db.getAuditByName(auditName);
  
  if (auditExist) {
    alert.display = "display:block";
    res.render('index', {appName: 'Ranch Control', title: 'Manage Audit', audits, alert, hidden:''});
    return;
  }
  try {
    await global.db.addAudit({ auditName , status: 'started'});
    res.redirect('/');

  } catch (error) {
    res.send('error');
  }
});

router.get('/auditinfo/:id', async function(req, res, next) {
  const id = parseInt(req.params.id);

  const auditedItems = await global.db.getAuditInfo(id);
  const auditName = await global.db.getAuditName(id);
  const unauditedItems = await global.db.getUnauditedItems(id);
  let auditinfo = { appName: 'Ranch Control'};
  auditinfo.auditedItems = auditedItems;
  auditinfo.auditName = auditName[0].name;
  auditinfo.action= '/auditinfo/' + id;
  auditinfo.auditId= id;
  auditinfo.jsontags= JSON.stringify(unauditedItems[0]);
  auditinfo.hidden = 'hidden';
  res.render('auditInfo', auditinfo);
});

router.post('/auditinfo/:id', async function(req, res, next) {
  const id = parseInt(req.params.id);
  const tag = parseInt(req.body.tag);

  try {
    await global.db.addLivestockAudit(id, tag);
    res.redirect('/auditinfo/' +req.params.id + '/?add=true');
  } catch (error) {
    res.redirect('/auditinfo/' +req.params.id + '/?error=' + error);
  }
  
});
router.get('/auditinfo/delete/:tag', async function(req, res, next) {
  const tag = parseInt(req.params.tag);
  const auditId = parseInt(req.query.audit);

  try {
    await global.db.removeLivestockAudit(auditId, tag);
    res.redirect('/auditinfo/' +auditId);
  } catch (error) {
    res.send(error);
  }
  
});
router.get('/delete/:id', async function(req, res, next) {
  const id = parseInt(req.params.id);

  try {
    await global.db.removeAudit(id);
    res.redirect('/');
  } catch (error) {
    res.send(error);
  }
  
});

router.get('/livestockdetails/:tag', async function(req, res, next) {
  const tag = req.params.tag;
  let details = await global.db.getLivestockDetails(tag);
  details.hidden = 'hidden';
  // if (details.date_of_birth)  details.date_of_birth = details.date_of_birth.toISOString().substr(0, 10);
  console.log(details);
  res.render('livestockdetails', details);
});

module.exports = router;
