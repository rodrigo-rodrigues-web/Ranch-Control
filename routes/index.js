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

router.get('/registerlivestock', async function(req, res, next) {
  let details ={};
  details.hidden = 'hidden';
  res.render('registerlivestock', details);
});

router.post('/registerlivestock', async function(req, res, next) {
  req.body.category = categoryId(parseInt(req.body.weight));
  await global.db.registerlivestock(req.body.notes, req.body.livestocktype, req.body.tag, req.body.category, req.body.color, req.body.weight, req.body.birth);
  res.redirect('/');
});

function categoryId(w) {
  const weight = parseInt(w);
  
  if (weight < 200) {
    return 100;
  } else if(weight < 300){
    return 200;
  } else if (weight < 450){
    return 300;
  } else if(weight < 500){
    return 400;
  } else if(weight < 600){
    return 500;
  } else {
    return 600;
  }
}

module.exports = router;
