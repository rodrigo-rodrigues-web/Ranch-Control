var express = require('express');
var router = express.Router();
let audits;
let alert;
/* GET home page. */
router.get('/', async function(req, res, next) {
  alert = {display:"display:none", message:"The audit name already exist. Enter a unique name."}
  audits = await global.db.getAudits();
  res.render('index', { appName: 'Ranch Control', title: 'Manage Audit', audits, alert });
});

router.post('/newaudit', async function(req, res){

  const auditName = req.body.auditName
  const auditExist = await global.db.getAuditByName(auditName);
  
  if (auditExist) {
    alert.display = "display:block";
    // res.redirect('/');
    res.render('index', { appName: 'Ranch Control', title: 'Manage Audit', audits, alert });
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

  res.render('auditInfo', { appName: 'Ranch Control', auditedItems:auditedItems[0], auditName:auditName[0],  action: '/auditinfo/' + id, auditId:id});
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

router.get('/getJsonTags/:id', async function(req, res, next) {
  const id = parseInt(req.params.id);
  const unaudited = await global.db.getUnauditedItems(id);
  res.json(unaudited[0]);
});

module.exports = router;
