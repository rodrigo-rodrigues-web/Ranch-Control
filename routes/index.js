var express = require('express');
var router = express.Router();
let audits;
/* GET home page. */
router.get('/', async function(req, res, next) {
  
  audits = await global.db.getAudits();
  res.render('index', { appName: 'Ranch Control', title: 'Manage Audit', audits });
});

router.post('/newaudit', async function(req, res){
  const name = req.body.auditName;
  // const auditExist = audits.map(e => e.name).indexOf(name);
  // if(auditExist){
  //   console.log("Audit alredy exist");
  //   return;
  // }
  
  try {
    await global.db.addAudit({ name , status: 'started'});
    res.redirect('/?new=true');

  } catch (error) {
    res.redirect('/?error=' + error);
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
    // res.redirect('/auditinfo/' +req.params.tag + '/?error=' + error);
  }
  
});

router.get('/getJsonTags/:id', async function(req, res, next) {
  const id = parseInt(req.params.id);
  const unaudited = await global.db.getUnauditedItems(id);
  res.json(unaudited[0]);
});

module.exports = router;
