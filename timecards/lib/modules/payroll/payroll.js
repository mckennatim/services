var express = require('express');
var router = express.Router();
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var combinePuJc = require('../../utilities').combinePuJc
var bearerTokenCoid = require('../regtokau/strategy').bearerTokenCoid


module.exports = function() {
    router.get('/', function(req, res) {
        res.jsonp({ message: "in root of payroll module" })
    });
    router.get('/settings', bearerTokenCoid, function(req, res) {
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
    router.get('/rates', bearerTokenCoid, function(req, res) {
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
    router.get('/submitted', bearerTokenCoid, function(req, res) {
        if (!req.userTok.auth) {
            var mess = { message: 'in get /payroll/submitted (not authorized)-' + req.userTok.message }
            cons.log(mess)
            res.jsonp(mess)
        } else {
            var query = conn.query('SELECT wprt, emailid, hrs, `status` FROM tcardwk WHERE status="submitted" AND coid=? ORDER BY wprt,emailid', req.userTok.coid, function(error, wstat) {
                cons.log(query.sql)
                cons.log(error)
                res.jsonp(wstat)
            })

        }
    })
    router.get('/approved', bearerTokenCoid, function(req, res) {
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
    router.get('/tcard/:wprt/:emailid', bearerTokenCoid, function(req, res) {
        if (!req.userTok.auth) {
            var mess = { message: 'in get /payroll/tcard (not authorized)-' + req.userTok.message }
            cons.log(mess)
            res.jsonp(mess)
        } else {
            cons.log('req.params: ', req.params)
            const wprt = req.params.wprt
            const wk = wprt.slice(-2)*1
            cons.log('wk: ', wk)
            const emailid =req.params.emailid
            const wdprt = `${wprt}%`
            var query0 = conn.query('SELECT `wprt`, `emailid`, `status`, `hrs` FROM tcardwk WHERE emailid = ? AND coid = ? AND wprt =?', [emailid, req.userTok.coid, wprt], function(error0, wstat) {
                cons.log(query0.sql)
                cons.log(error0)
                cons.log(wstat)
                cons.log(wdprt)
                var query = conn.query('SELECT `wdprt`, `inout`, `hrs` FROM tcardpu WHERE emailid = ? AND coid = ? AND wdprt LIKE(?)', [emailid, req.userTok.coid, wdprt], function(error1, punch) {
                    cons.log(query.sql)
                    cons.log(error1)
                    var query2 = conn.query('SELECT `wdprt`, `job`, `cat`, `hrs` FROM tcardjc WHERE emailid = ? AND coid = ? AND wdprt LIKE(?)', [emailid, req.userTok.coid, wdprt], function(error2, jcost) {
                        cons.log(query2.sql)
                        cons.log(error2)
                        cons.log(jcost)
                        cons.log(punch)
                        var q = conn.query('SELECT `job`, `category` FROM jobcatact WHERE week=? AND coid=? ORDER BY idx, category', [wk, req.userTok.coid], function(error3, jobs) {
                            cons.log(q.sql)
                            cons.log(jobs)
                            cons.log(error3)
                            const wkarr = combinePuJc(punch, jcost, wk, emailid)
                            res.jsonp({ wk: wk, wkarr: wkarr, jobs: jobs, wstat: wstat[0] })
                        })
                    })
                })
            })
        }
    });
    return router;
}