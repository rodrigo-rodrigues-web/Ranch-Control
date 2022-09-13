var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', async function(req, res, next) {
  
  const results = await global.db.getAudits();
  console.log(results);
  res.render('index', { appName: 'Ranch Control', title: 'Manage Audit', audits: results });
});

module.exports = router;
