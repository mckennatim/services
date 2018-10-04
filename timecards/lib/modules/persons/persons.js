var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
// var bearerTokenApp = require('../regtokau/strategy').bearerTokenApp
var bearerTokenCoid = require('../regtokau/strategy').bearerTokenCoid

var router = express.Router();

module.exports = function() {
  router.get('/', function(req, res) {
    res.jsonp({ message: "in root of persons module" })
  });
  router.put('/update', bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /persons/update (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      mess = { message: 'nothing happenning yet-' }
      const p = req.body.person
      const roho ={emailid:p.emailid, role:p.role, coid:req.userTok.coid, active:p.active}
      const per ={emailid:p.emailid, coid:req.userTok.coid, firstmid:p.firstmid, lastname:p.lastname, street:p.street, city:p.city, st:p.st, zip:p.zip,rate:p.rate, ssn:p.ssn, w4allow:p.w4allow, w4add:p.w4add, stallow:p.stallow, stadd:p.stadd, sthoh: p.sthoh, stblind:p.stblind, effective:p.effective, marital:p.marital, w4exempt:p.w4exempt, student: p.student }
      const iroho = conn.query('INSERT INTO rolewho SET ? ON DUPLICATE KEY UPDATE ?', [roho,roho], function(err0) {
        cons.log('iroho.sql: ', iroho.sql)
        cons.log('err0: ', err0)
        const iper = conn.query('INSERT INTO persons SET ? ON DUPLICATE KEY UPDATE ?', [per,per], function(err) {
          cons.log('iper.sql: ', iper.sql)
          cons.log('err: ', err)
          res.jsonp(mess)
        })
      })
    }
  });
  router.put('/ck', bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /persons/update (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      if(req.body.job.week>0){
        const ckq = conn.query('DELETE FROM jobcatact WHERE id = ?', req.body.job.id, function(){
          cons.log('ckq.sql: ', ckq.sql)
          res.jsonp({message: 'done,I hope'})
        })
      }else{
        const ckq = conn.query('UPDATE jobcatact SET active = ? WHERE id = ?',[req.body.job.active, req.body.job.id], function(){
          cons.log('ckq.sql: ', ckq.sql)
          res.jsonp({message: 'done,I hope'})
        })
      }
    }
  })
  router.get('/list/', bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /persons/list/ (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      cons.log(req.userTok);
      var q = conn.query('SELECT p.effective, r.id, r.emailid, r.role, p.`firstmid`, p.`lastname`, p.`street`, p.`city`, p.`st`, p.`zip`, p.`ssn`, p.marital, p.rate, p.w4add, p.stadd, p.sthoh, p.stblind, p.w4exempt, p.`w4allow`, p.student, p.`stallow`, r.`active`, p.`effective`, p.`coid` FROM rolewho r LEFT JOIN persons p ON p.emailid = r.emailid AND p.coid =r.coid WHERE r.coid= ?  ORDER BY r.emailid,p.effective DESC',  req.userTok.coid, function(error, results) {
        cons.log(q.sql)
        cons.log(error)
        var arrres = results.map((res) => res)
        res.jsonp({ persons: arrres, binfo: req.userTok })
      })
    }
  })
  router.get('/current/', bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /persons/current (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      cons.log(req.userTok);
      var q = conn.query('DROP TABLE IF EXISTS `timecards`.`cureff`; CREATE TABLE `timecards`.`cureff` SELECT p.emailid , MAX(p.effective) AS curedate FROM `timecards`.`persons` p WHERE effective < CURDATE() AND p.coid =? AND p.active=1 GROUP BY p.emailid; DROP TABLE IF EXISTS `timecards`.`cureffective`; CREATE TABLE `timecards`.`cureffective` SELECT p.* FROM `timecards`.`cureff` c JOIN `timecards`.`persons` p ON c.emailid=p.emailid AND c.curedate=p.effective; SELECT * FROM `timecards`.`cureffective`;',  req.userTok.coid, function(error, results) {
        cons.log(q.sql)
        cons.log(error)
        var arrres = results.slice(-1)[0]
        res.jsonp({ persons: arrres, binfo: req.userTok })
      })
    }
  })
  router.get('/tokdata/', bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /persons/list/:wk (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      cons.log(req.userTok);
      res.jsonp({ binfo: req.userTok })
    }
  }) 
  router.post('/post/:wk', bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /persons/list (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      mess = { message: 'nothing happenning yet-' }
      const week = req.params.wk * 1
      cons.log(req.body)
      const keys = Object.keys(req.body.persons[0]).join()+',coid'
      const vals = [req.body.persons.map((j) => {
        let anarr = Object.values(j)
        anarr.push(req.userTok.coid)
        return anarr
      })]
      console.log(keys);
      console.log(vals);
      var query1 = conn.query('DELETE FROM jobcatact WHERE week=? AND coid=?', [week, req.userTok.coid], function(error, results) {
        cons.log(query1.sql)
        cons.log(error)
        cons.log(results)
        var query = conn.query('INSERT INTO jobcatact (' + keys + ') VALUES ? ', vals, function(error, results) {
          cons.log(query.sql)
          cons.log(error)
          cons.log(results)
          cons.log(mess)
          res.jsonp(mess)
        })
      })
    }
  })
  router.delete('/del', bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /persons/list (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      mess = { message: 'nothing happenning yet-' }
      cons.log(req.body)
      var query1 = conn.query('DELETE FROM persons WHERE emailid=? AND coid=? AND effective=?', [req.body.person.emailid, req.userTok.coid, req.body.person.effective], function(error, results) {
        cons.log(query1.sql)
        cons.log(error)
        cons.log(results)
        res.jsonp(mess)
      })
    }
  })
  return router
}