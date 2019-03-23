var express = require('express');
var router = express.Router();
var cons = require('tracer').console();
var moment = require('moment');
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
      var mess = { message: 'in get /payroll/jc (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      const {jcrates} = req.body
      jcrates.ratearr.map((hrcost,i)=>{
        const wdprt = jcrates.wprt+'-'+(i+1)
        console.log('wdprt: ', wdprt)
        console.log('hrcost: ', hrcost)
        const seljc = conn.query('SELECT * FROM tcardjc WHERE emailid= ? AND wdprt = ? AND coid = ? ; UPDATE tcardwk SET status=? WHERE coid=? AND wprt=? AND emailid=?',[jcrates.emailid, wdprt, req.userTok.coid, 'paid', req.userTok.coid, jcrates.wprt, jcrates.emailid], function(error1, sesults){
          cons.log(seljc.sql)
          cons.log(error1)
          cons.log('results: ', sesults[0])
          sesults[0].map((s)=>{
            const cst = hrcost*s.hrs
            const updjc =conn.query("INSERT INTO gl (coid, account, wdprt, job,cat,date,someid,somenum,debit) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?);  UPDATE tcardjc SET hrcost=?, cost=? WHERE id = ?; UPDATE gl SET account='a6000-labor' WHERE job = 'labor expense';",[s.coid, 'a5010-COGS', s.wdprt, s.job, s.cat, jcrates.paydate, s.emailid, s.hrs, cst, hrcost, cst, s.id], function(error, results){
              cons.log(updjc.sql)
              cons.log(error)
              cons.log('results: ', results)
            })
          })
        })
      })
      res.jsonp({binfo: req.userTok })  
    } 
  })

  router.post('/gl', addAppId, bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/gl (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      const {journal, paydate, emailid} = req.body
      cons.log(journal)
      const keys = Object.keys(req.body.journal[0]).join()+',coid'
      const vals = [req.body.journal.map((j) => {
        let anarr = Object.values(j)
        anarr.push(req.userTok.coid)
        return anarr
      })]
      // const emailid = vals[0][2]
      // const pdate = vals[0][5]
      // cons.log('keys: ', keys)
      var query = conn.query('INSERT INTO gl (' + keys + ') VALUES ? ', vals, function(error, results) {
          cons.log(query.sql)
          cons.log(error)
          cons.log(results)
          // const qtrba = conn.query('SELECT SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE coid =?',req.userTok.coid, function(errtrba, restrba){
          const qtrba = conn.query("SELECT someid, `date`, SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE `date`=? AND  someid=? AND coid = ? GROUP BY someid, `date` ",[paydate, emailid, req.userTok.coid], function(errtrba, restrba){
            cons.log(qtrba.sql)
            cons.log(errtrba)
            cons.log(restrba)
            cons.log(mess)
            //res.jsonp({errtrba:errtrba, tribal: restrba, error:error, keys:keys, emailid:emailid, paydate:paydate})
            res.jsonp({errtrba:errtrba, tribal: restrba, error:error, paydate:paydate, emailid:emailid})
          })
      })
    }
  })
  router.post('/payment', addAppId, bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/payment (not authorized)-' + req.userTok.message }
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
      var query = conn.query('INSERT INTO gl (' + keys + ') VALUES ? ', vals, function(error, results) {
          cons.log(query.sql)
          cons.log(error)
          cons.log(results)
          res.jsonp({results, error})
      })
    }
  })

  router.post('/stub', addAppId, bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/paystub (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      const {paystub} = req.body
      cons.log(paystub)
      var query = conn.query('INSERT INTO paystubs SET ? ', paystub, function(error, results) {
          cons.log(query.sql)
          cons.log(error)
          cons.log(results)
          res.jsonp({results, error})
      })
    }
  })

  router.get('/stubs', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in get /payroll/stubs (not authorized)-' + req.userTok.message }
        cons.log(mess)
        res.jsonp(mess)
    } else {
        var query = conn.query('SELECT * FROM `timecards`.`paystubs` WHERE coid =? ORDER BY week DESC LIMIT 25 ', req.userTok.coid, function(error, payres) {
            cons.log(query.sql)
            cons.log(error)
            res.jsonp(payres)
        })

    }
})

  router.post('/payment', addAppId, bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/payment (not authorized)-' + req.userTok.message }
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
      var query = conn.query('INSERT INTO gl (' + keys + ') VALUES ? ', vals, function(error, results) {
          cons.log(query.sql)
          cons.log(error)
          cons.log(results)
          res.jsonp({results, error})
      })
    }
  })  
  router.put('/bid', addAppId, bearerTokenCoid, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/bid (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      const {bid} = req.body
      bid.coid =req.userTok.coid 
      var query = conn.query('INSERT INTO bids SET ? ON DUPLICATE KEY UPDATE ?', [bid, bid], function(error, results) {
        cons.log('query.sql: ', query.sql)
        cons.log(bid)
        res.jsonp({bid, results})
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
          var query = conn.query('SELECT * FROM `timecards`.`cosr` WHERE effective <= CURDATE() AND coid =? ORDER BY effective DESC LIMIT 1 ', req.userTok.coid, function(error, settings) {
              cons.log(query.sql)
              cons.log(error)
              res.jsonp(settings)
          })

      }
  })
  router.get('/accrued', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in get /payroll/accrued (not authorized)-' + req.userTok.message }
        cons.log(mess)
        res.jsonp(mess)
    } else {
        var query = conn.query("SELECT someid, account, SUM(somenum) as hrs, SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE wdprt like(CONCAT(YEAR(CURDATE()),'%')) AND coid = ? GROUP BY someid,account", req.userTok.coid, function(error, accrued) {
            cons.log(query.sql)
            cons.log(error)
            res.jsonp(accrued)
        })
    }
  })  


  router.get('/bids', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in get /payroll/bids (not authorized)-' + req.userTok.message }
        cons.log(mess)
        res.jsonp(mess)
    } else {
        var query = conn.query("SELECT job, labor FROM bids WHERE coid=?", req.userTok.coid, function(error, bids) {
            cons.log(query.sql)
            cons.log(error)
            res.jsonp(bids)
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
              const q2 = conn.query("SELECT * FROM `timecards`.`cosr` WHERE effective <= CURDATE() AND coid =? ORDER BY effective DESC LIMIT 1; SELECT * FROM `timecards`.`fedr` WHERE year = YEAR(CURDATE()); SELECT * FROM `timecards`.`fedwh` WHERE year = YEAR(CURDATE()); SELECT * FROM `timecards`.`strates` WHERE year = YEAR(CURDATE()) AND st= ?; ", [req.userTok.coid, st], (error2, rr)=>{
                  cons.log(q2.sql)
                  cons.log(error2)
                  res.jsonp({cosr: rr[0][0], fedr:rr[1][0], fedwh:rr[2], strates:rr[3][0]})
              })
          })
      }
  })

  router.get('/state/:st', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get payroll/state/:st (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      const st =req.params.st
      var query = conn.query("SELECT * FROM `timecards`.`strates` WHERE year = YEAR(CURDATE()) AND st= ? ", st, function(error, results) {
        cons.log(query.sql)
        cons.log(error)
        res.jsonp(results)
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
          var query = conn.query("DROP TABLE IF EXISTS `timecards`.`cureff` ; CREATE TABLE `timecards`.`cureff` SELECT p.emailid , MAX(p.effective) AS curedate FROM `timecards`.`persons` p WHERE effective <= CURDATE() AND p.coid =? GROUP BY p.emailid; DROP TABLE IF EXISTS `timecards`.`cureffective` ; CREATE TABLE `timecards`.`cureffective` SELECT p.* FROM `timecards`.`cureff` c JOIN `timecards`.`persons` p ON c.emailid=p.emailid AND c.curedate=p.effective AND p.coid =?; SELECT t.*, c.* FROM `timecards`.`tcardwk` t JOIN `timecards`.`cureffective` c ON c.emailid = t.emailid WHERE t.status='approved' AND t.coid= ? ORDER BY t.wprt, t.emailid;",[coid,coid,coid] , function(error, results) {
              cons.log(query.sql)
              cons.log(error)
              var arrres = results.slice(-1)[0]
              res.jsonp({ persons: arrres, binfo: req.userTok })
          })

      }
  })

  router.get('/taxes/:year', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/taxes/:year (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      const coid = req.userTok.coid
      const year = req.params.year
      var query = conn.query("SELECT account, YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo, SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE coid = ? AND YEAR(`date`) = ? AND ( account='a6041-fedTaxable' || account='a2050-fedWh' || account='a2060-stWh' || account='a6051-stateTaxable' || account='a2010-SS' || account='a2020-medi' || account='a6061-FICAtaxable' || account='a6070-addFICA' || account='a2030-meda' ) GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), coid, account; SELECT COUNT(DISTINCT(someid)) as numempl, YEAR(`date`) as year, QUARTER(`date`) as qtr FROM gl WHERE coid = ? AND YEAR(`date`) = ? GROUP BY YEAR(`date`), QUARTER(`date`); SELECT account, YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE coid = ? AND YEAR(`date`) = ?  AND ( account='a6041-fedTaxable' || account='a2050-fedWh' || account='a2060-stWh' || account='a6051-stateTaxable' || account='a2010-SS' || account='a2020-medi' || account='a6061-FICAtaxable' || account='a6070-addFICA' || account='a2030-meda' ) GROUP BY YEAR(`date`), QUARTER(`date`),coid, account; SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo, MONTHNAME(`date`) as month, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = ? AND YEAR(`date`)= ? AND ( account='a2010-SS' || account='a2020-medi' || account='a2020-meda' || account='a2050-fedWh') GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), MONTHNAME(`date`); SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = ? AND YEAR(`date`)= ? AND ( account='a2010-SS' || account='a2020-medi' || account='a2020-meda' || account='a2050-fedWh' ) GROUP BY YEAR(`date`), QUARTER(`date`); SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo, MONTHNAME(`date`) as month, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = ? AND YEAR(`date`)= ? AND ( account='a2060-stWh' ) GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), MONTHNAME(`date`); SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = ? AND YEAR(`date`)= ? AND ( account='a2060-stWh' ) GROUP BY YEAR(`date`), QUARTER(`date`)",[coid,year,coid,year,coid,year,coid, year,coid, year,coid,year,coid,year] , function(error, results) {
        cons.log(query.sql)
        cons.log(error)
        res.jsonp({ results: results, binfo: req.userTok })
      })
    }
  })

  router.get('/payments/:year', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/payments/:year (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      const coid = req.userTok.coid
      const year = req.params.year
      var query = conn.query("SELECT wdprt as ref, job as gov, QUARTER(`date`)as qtr, MONTH(`date`)as mo, MONTHNAME(`date`) as month, someid as paydate, credit as paid FROM gl WHERE YEAR(`date`)=? AND coid =? AND account = 'a1010-cash' AND (job='fed' OR job='state') AND cat='WhTaxPayment' AND credit>0 ORDER BY job, `date` ",[year,coid] , function(error, results) {
        cons.log(query.sql)
        cons.log(error)
        res.jsonp({ results: results, binfo: req.userTok })
      })
    }
  })

  router.get('/qtr/state/:year/:qtr', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/qtr/state/:year/:qtr (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      const coid = req.userTok.coid
      const year = req.params.year
      const qtr = req.params.qtr
      const fmo = moment(`${year}-${qtr}`,'YYYY-Q').format('M')*1
      /*
      How many paychecks did each worker get for each month of the quarter
      */
      let qnum = "SELECT DISTINCT(someid) as employee, "
      for (var i = fmo; i<fmo+3; i++){
        const mmm = moment(`${year}-${i}`,'YYYY-M').format('MMM')
        const c = `COUNT(CASE WHEN MONTH(\`date\`)=${i} THEN debit END) as '${mmm}'`
        qnum += c+ ', '
      }
      qnum=  qnum.slice(0,-2)+"FROM gl WHERE coid = ? AND YEAR(`date`) = ? AND QUARTER(`date`)= ? AND account = 'a6050-stateWages' GROUP BY someid; "
      
      /*
      What were wages, taxable wages and witholding for quarter
      */
      const qtot ="SELECT  DISTINCT QUARTER(`date`) as qtr,  \
      SUM(CASE WHEN account='a6050-stateWages' THEN debit END) as 'a6050-stateWages', \
      SUM(CASE WHEN account='a6051-stateTaxable' THEN credit END) as 'a6051-stateTaxable', \
      SUM(CASE WHEN account='a2060-stWh' THEN credit END) as 'a2060-stWh', \
      SUM(CASE WHEN account='a2060-stWh' THEN debit END) as 'a2060-stWh-paid' \
      FROM gl \
      WHERE coid = ? \
      AND YEAR(`date`) = ? \
      AND QUARTER(`date`) =? \
      AND ( \
        account='a6050-stateWages' || \
        account='a6051-stateTaxable' || \
        account='a2060-stWh' \
        )  \
      GROUP BY QUARTER(`date`); " 
      /*
      What were wages, taxable wages and witholding for quarter by person
      */
      let qemp = "SELECT  DISTINCT someid as employee, \
      SUM(CASE WHEN account='a6050-stateWages' THEN debit END) as 'a6050-stateWages', \
      SUM(CASE WHEN account='a6051-stateTaxable' THEN credit END) as 'a6051-stateTaxable', \
      SUM(CASE WHEN account='a2060-stWh' THEN credit END) as 'a2060-stWh' \
      FROM gl \
      WHERE coid = ? \
      AND YEAR(`date`) = ? \
      AND QUARTER(`date`)= ? \
      AND someid NOT LIKE 'paid%' \
      AND ( \
        account='a6050-stateWages' || \
        account='a6051-stateTaxable' || \
        account='a2060-stWh' \
        ) \
      GROUP BY someid; " 
      /*
      List state witholding payments for quarter
      */
      let qpmt = "SELECT MONTH(`date`) as `month`, \
      someid as date_paid, \
      debit as amount \
      FROM gl \
      WHERE account='a2060-stWh' \
      AND coid=? \
      AND YEAR(`date`)=? \
      AND QUARTER(`date`)= ? \
      AND debit>0 \
      ORDER BY MONTH(`date`); "
      /*
      What state payments and acruals for witholding for year
      */
      let yrpayaccr = "SELECT QUARTER(`date`) as qtr, \
      MONTHNAME(`date`) as month, \
      SUM(debit) as paid, SUM(credit) as accrued \
      FROM gl \
      WHERE account='a2060-stWh' \
      AND coid= ? \
      AND YEAR(`date`)= ? \
      GROUP BY QUARTER(`date`), MONTHNAME(`date`)"
      
      var anum = [coid, year, qtr]
      const ayrpayaccr=[coid, year]
      const allres = {}
      const qn = conn.query(qnum, anum, (err,rnum)=>{
        allres.qnumemp=rnum
        console.log('qn.sql: ', qn.sql)
        const qt = conn.query(qtot, anum, (err,rtot)=>{
          allres.qtot=rtot
          console.log('qt.sql: ', qt.sql)
          const qe = conn.query(qemp, anum, (err,remp)=>{
            allres.qemp=remp
            console.log('qe.sql: ', qe.sql)
            const qp = conn.query(qpmt, anum, (err,rpmt)=>{
              allres.qpmt=rpmt
              console.log('qp.sql: ', qp.sql) 
              const qy = conn.query(yrpayaccr, ayrpayaccr, (err,ryrp)=>{
                allres.yrpayaccr=ryrp
                console.log('qy.sql: ', qy.sql)
                console.log('allres: ', allres) 
                res.jsonp({st:allres}) 
              }) 
            })  
          })      
        })
      })
    }
  })

  router.get('/jobcosts/:year', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /payroll/jobcosts/:year (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      const coid = req.userTok.coid
      const year = req.params.year
      var query = conn.query("SELECT job, SUM(somenum) as hrs, SUM(debit) as cost, ROUND(SUM(debit)/SUM(somenum),2) as hrcost FROM gl WHERE account = 'a5010-COGS' AND YEAR(`date`)= ? AND coid =? GROUP BY job ORDER BY job; SELECT job, cat, SUM(somenum) as hrs, SUM(debit) as cost, ROUND(SUM(debit)/SUM(somenum),2) as hrcost FROM gl WHERE account = 'a5010-COGS' AND YEAR(`date`)= ? AND coid =? GROUP BY job,cat ORDER BY job,cat; SELECT job, cat, someid, SUM(somenum) as hrs, SUM(debit) as cost, ROUND(SUM(debit)/SUM(somenum),2) as hrcost FROM gl WHERE account = 'a5010-COGS' AND YEAR(`date`)= ? AND coid =? GROUP BY job,cat, someid ORDER BY job,cat,someid; ",[year,coid,year,coid,year,coid] , function(error, results) {
        cons.log(query.sql)
        cons.log(error)
        res.jsonp({ results: results, binfo: req.userTok })
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