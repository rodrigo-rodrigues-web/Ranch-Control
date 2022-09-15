var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', async function(req, res, next) {
  
  const results = await global.db.getAudits();
  res.render('index', { appName: 'Ranch Control', title: 'Manage Audit', audits: results });
});

router.post('/newaudit', async function(req, res){
  const name = req.body.auditName;

  try {
    await global.db.addAudit({ name , status: 'started'});
    res.redirect('/?new=true');

  } catch (error) {
    res.redirect('/?error=' + error);
  }
});

router.get('/auditinfo/:id', async function(req, res, next) {
  const id = parseInt(req.params.id);

  const results = await global.db.getAuditInfo(id);
  console.log(results[0]);
  res.render('auditInfo', { appName: 'Ranch Control', title: 'Audit Information', list:results[0]});
});

module.exports = router;
