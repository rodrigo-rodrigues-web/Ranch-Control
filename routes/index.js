var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', async function(req, res, next) {
  
  const results = await global.db.getAudits();
  console.log(results);
  res.render('index', { appName: 'Ranch Control', title: 'Manage Audit', audits: results });
});

router.post('/newaudit', async function(req, res){
  const name = req.body.auditName;
  console.log(name);

  try {
    await global.db.addAudit({ name , status: 'started'});
    res.redirect('/?new=true');

  } catch (error) {
    res.redirect('/?error=' + error);
  }
});

module.exports = router;
