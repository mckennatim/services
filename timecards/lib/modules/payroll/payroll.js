var express = require('express');
var router = express.Router();
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
// var combinePuJc = require('../../utilities').combinePuJc
var bearerTokenCoid = require('../regtokau/strategy').bearerTokenCoid
//var bearerTokenApp = require('../regtokau/strategy').bearerTokenApp
// var env = require('../../../env.json')
//var cfg = env[process.env.NODE_ENV || 'development']
//var secret = cfg.secret
function addAppId(req,res,next){
  req.appid = 'pay'
  next()
}

module.exports = function() {
  router.get('/', function(req, res) {
      res.jsonp({ message: "in root of payroll module" })
  });
  router.post('/jc', addAppId, bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/ckcoid (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      const {jcrates} = req.body
      console.log('req.body.jcrates: ', req.body.jcrates)
      console.log('ratearr: ', req.body.jcrates[0].ratearr)
      jcrates.map((j)=>{
        j.ratearr.map((hrcost,i)=>{
          const wdprt = j.wprt+'-'+(i+1)
          console.log('wdprt: ', wdprt)
          console.log('hrcost: ', hrcost)
          const seljc = conn.query('SELECT * FROM tcardjc WHERE emailid= ? AND wdprt = ? AND coid = ? ; UPDATE tcardwk SET status=? WHERE coid=? AND wprt=? AND emailid=?',[j.emailid, wdprt, req.userTok.coid, 'paid', req.userTok.coid, j.wprt, j.emailid], function(error1, sesults){
            cons.log(seljc.sql)
            cons.log(error1)
            cons.log('results: ', sesults[0])
            sesults[0].map((s)=>{
              const cst = hrcost*s.hrs
              const updjc =conn.query("INSERT INTO gl (coid, account, wdprt, job,cat,someid,somenum,debit) VALUES (?, ?, ?, ?, ?, ?, ?, ?);  UPDATE tcardjc SET hrcost=?, cost=? WHERE id = ?",[s.coid, 'a5010-COGS'  , s.wdprt, s.job, s.cat, s.emailid, s.hrs, cst, hrcost, cst, s.id], function(error, results){
                cons.log(updjc.sql)
                cons.log(error)
                cons.log('results: ', results)
              })
            })
          })
        })
      })
      res.jsonp({binfo: req.userTok })  
    } 
  })

  router.post('/gl', addAppId, bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/ckcoid (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      const {journal} = req.body
      cons.log(journal)
      const keys = Object.keys(req.body.journal[0]).join()+',coid'
      const vals = [req.body.journal.map((j) => {
        let anarr = Object.values(j)
        anarr.push(req.userTok.coid)
        return anarr
      })]
      console.log(keys);
      console.log(vals);
      var query = conn.query('INSERT INTO gl (' + keys + ') VALUES ? ', vals, function(error, results) {
          cons.log(query.sql)
          cons.log(error)
          cons.log(results)
          cons.log(mess)
          res.jsonp(mess)
      })
    }
  })
  // router.post('/ckcoid', bearerTokenApp, function(req,res){
  //     if (!req.userTok.auth) {
  //       var mess = { message: 'in get /payroll/ckcoid (not authorized)-' + req.userTok.message }
  //       res.jsonp(mess)
  //     } else {
  //       cons.log('req.userTok: ', req.userTok)
  //       cons.log('req.body: ', req.body) 
  //       var query = conn.query('SELECT coid FROM `timecards`.`co` WHERE coid=?', req.body.co.coid, function(error, copman) {
  //           cons.log(query.sql)
  //           cons.log(error)
  //           if(copman.length>0){
  //             res.jsonp({message: 'coid already exists, try another' })
  //           }else{
  //             const goodtil = moment().add(30, 'days').format('YYYY-MM-DD')
  //             const effective = moment().format('YYYY-MM-DD')
  //             var query2 = conn.query("INSERT INTO `timecards`.`co` (goodtil, coid) VALUES(?,?); INSERT INTO `timecards`.`rolewho` (role, emailid, coid,active) VALUES('partner',?,?,1); INSERT INTO `timecards`.`journal` (emailid, coid, effective) VALUES(?,?,?); INSERT INTO `timecards`.`cosr` (coid, effective) VALUES(?,?); ", [goodtil, req.body.co.coid, req.body.co.emailid, req.body.co.coid, req.body.co.emailid, req.body.co.coid, effective, req.body.co.coid, effective], function(error2, result) {
  //               cons.log(query2.sql)
  //               cons.log(error2)
  //               cons.log(result)
  //               const exp = Math.floor(Date.now()) + addDays(40)
  //               cons.log('exp: ', exp)
  //               var payload = {
  //                 coid: req.body.co.coid,
  //                 role: 'partner',
  //                 appid: 'signup',
  //                 emailid: req.body.co.emailid,
  //                 exp: exp
  //               };
  //               var token = jwt.encode(payload, secret);
  //               res.jsonp({message: 'ok setting you up', goodtil:goodtil,result:result, token:token, emailid:req.body.co.emailid})
  //             })
  //           }
  //       })  
  //     }
  //   })

  router.get('/settings', addAppId, bearerTokenCoid, function(req, res) {
      if (!req.userTok.auth) {
          var mess = { message: 'in get /payroll/settings (not authorized)-' + req.userTok.message }
          cons.log(mess)
          res.jsonp(mess)
      } else {
          var query = conn.query('SELECT * FROM `timecards`.`cosr` WHERE effective < CURDATE() AND coid =? ORDER BY effective DESC LIMIT 1 ', req.userTok.coid, function(error, settings) {
              cons.log(query.sql)
              cons.log(error)
              res.jsonp(settings)
          })

      }
  })
  router.get('/rates', addAppId,  bearerTokenCoid, function(req, res) {
      if (!req.userTok.auth) {
          var mess = { message: 'in get /payroll/rates (not authorized)-' + req.userTok.message }
          cons.log(mess)
          res.jsonp(mess)
      } else {
          var query = conn.query('SELECT * FROM `timecards`.`co` WHERE coid=?', req.userTok.coid, function(error, cores) {
              cons.log(query.sql)
              cons.log(error)
              const st= cores[0].st
              const q2 = conn.query("SELECT * FROM `timecards`.`cosr` WHERE effective < CURDATE() AND coid =? ORDER BY effective DESC LIMIT 1; SELECT * FROM `timecards`.`fedr` WHERE year = YEAR(CURDATE()); SELECT * FROM `timecards`.`fedwh` WHERE year = YEAR(CURDATE()); SELECT * FROM `timecards`.`strates` WHERE year = YEAR(CURDATE()) AND st= ?; ", [req.userTok.coid, st], (error2, rr)=>{
                  cons.log(q2.sql)
                  cons.log(error2)
                  res.jsonp({cosr: rr[0][0], fedr:rr[1][0], fedwh:rr[2], strates:rr[3][0]})
              })
          })
      }
  })
  // router.get('/submitted', bearerTokenCoid, function(req, res) {
  //     if (!req.userTok.auth) {
  //         var mess = { message: 'in get /payroll/submitted (not authorized)-' + req.userTok.message }
  //         cons.log(mess)
  //         res.jsonp(mess)
  //     } else {
  //         var query = conn.query('SELECT wprt, emailid, hrs, `status` FROM tcardwk WHERE status="submitted" AND coid=? ORDER BY wprt,emailid', req.userTok.coid, function(error, wstat) {
  //             cons.log(query.sql)
  //             cons.log(error)
  //             res.jsonp(wstat)
  //         })

  //     }
  // })
  router.get('/approved', addAppId, bearerTokenCoid, function(req, res) {
      if (!req.userTok.auth) {
          var mess = { message: 'in get /payroll/approved (not authorized)-' + req.userTok.message }
          cons.log(mess)
          res.jsonp(mess)
      } else {
          const coid = req.userTok.coid
          var query = conn.query("DROP TABLE IF EXISTS `timecards`.`cureff` ; CREATE TABLE `timecards`.`cureff` SELECT p.emailid , MAX(p.effective) AS curedate FROM `timecards`.`persons` p WHERE effective < CURDATE() AND p.coid =? GROUP BY p.emailid; DROP TABLE IF EXISTS `timecards`.`cureffective` ; CREATE TABLE `timecards`.`cureffective` SELECT p.* FROM `timecards`.`cureff` c JOIN `timecards`.`persons` p ON c.emailid=p.emailid AND c.curedate=p.effective; SELECT t.*, c.* FROM `timecards`.`tcardwk` t JOIN `timecards`.`cureffective` c ON c.emailid = t.emailid WHERE t.status='approved' AND t.coid= ?;",[coid,coid] , function(error, results) {
              cons.log(query.sql)
              cons.log(error)
              var arrres = results.slice(-1)[0]
              res.jsonp({ persons: arrres, binfo: req.userTok })
          })

      }
  })
  // router.get('/tcard/:wprt/:emailid', bearerTokenCoid, function(req, res) {
  //     if (!req.userTok.auth) {
  //         var mess = { message: 'in get /payroll/tcard (not authorized)-' + req.userTok.message }
  //         cons.log(mess)
  //         res.jsonp(mess)
  //     } else {
  //         cons.log('req.params: ', req.params)
  //         const wprt = req.params.wprt
  //         const wk = wprt.slice(-2)*1
  //         cons.log('wk: ', wk)
  //         const emailid =req.params.emailid
  //         const wdprt = `${wprt}%`
  //         var query0 = conn.query('SELECT `wprt`, `emailid`, `status`, `hrs` FROM tcardwk WHERE emailid = ? AND coid = ? AND wprt =?', [emailid, req.userTok.coid, wprt], function(error0, wstat) {
  //             cons.log(query0.sql)
  //             cons.log(error0)
  //             cons.log(wstat)
  //             cons.log(wdprt)
  //             var query = conn.query('SELECT `wdprt`, `inout`, `hrs` FROM tcardpu WHERE emailid = ? AND coid = ? AND wdprt LIKE(?)', [emailid, req.userTok.coid, wdprt], function(error1, punch) {
  //                 cons.log(query.sql)
  //                 cons.log(error1)
  //                 var query2 = conn.query('SELECT `wdprt`, `job`, `cat`, `hrs` FROM tcardjc WHERE emailid = ? AND coid = ? AND wdprt LIKE(?)', [emailid, req.userTok.coid, wdprt], function(error2, jcost) {
  //                     cons.log(query2.sql)
  //                     cons.log(error2)
  //                     cons.log(jcost)
  //                     cons.log(punch)
  //                     var q = conn.query('SELECT `job`, `category` FROM jobcatact WHERE week=? AND coid=? ORDER BY idx, category', [wk, req.userTok.coid], function(error3, jobs) {
  //                         cons.log(q.sql)
  //                         cons.log(jobs)
  //                         cons.log(error3)
  //                         const wkarr = combinePuJc(punch, jcost, wk, emailid)
  //                         res.jsonp({ wk: wk, wkarr: wkarr, jobs: jobs, wstat: wstat[0] })
  //                     })
  //                 })
  //             })
  //         })
  //     }
  // });
  return router;
}

// function addDays (x){
//   return x*(24*60*60*1000)
// }