var express = require('express');
var router = express.Router();
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var combinePuJc = require('../../utilities').combinePuJc
var bearerTokenApp = require('../regtokau/strategy').bearerTokenApp


module.exports = function() {
    router.get('/', function(req, res) {
        res.jsonp({ message: "in root of payroll module" })
    });
    router.get('/settings', bearerTokenApp, function(req, res) {
        if (!req.userTok.auth) {
            var mess = { message: 'in get /payroll/settings (not authorized)-' + req.userTok.message }
            cons.log(mess)
            res.jsonp(mess)
        } else {
            var query = conn.query('SELECT * FROM `settings` WHERE `effective`< CURDATE() AND `coid` = ? ORDER BY `effective` DESC LIMIT 1', req.userTok.coId, function(error, settings) {
                cons.log(query.sql)
                cons.log(error)
                res.jsonp(settings)
            })

        }
    })
    router.get('/submitted', bearerTokenApp, function(req, res) {
        if (!req.userTok.auth) {
            var mess = { message: 'in get /payroll/submitted (not authorized)-' + req.userTok.message }
            cons.log(mess)
            res.jsonp(mess)
        } else {
            var query = conn.query('SELECT wprt, emailid, hrs, `status` FROM tcardwk WHERE status="submitted" AND coid=? ORDER BY wprt,emailid', req.userTok.coId, function(error, wstat) {
                cons.log(query.sql)
                cons.log(error)
                res.jsonp(wstat)
            })

        }
    })
    router.get('/tcard/:wprt/:emailid', bearerTokenApp, function(req, res) {
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
            var query0 = conn.query('SELECT `wprt`, `emailid`, `status`, `hrs` FROM tcardwk WHERE emailid = ? AND coid = ? AND wprt =?', [emailid, req.userTok.coId, wprt], function(error0, wstat) {
                cons.log(query0.sql)
                cons.log(error0)
                cons.log(wstat)
                cons.log(wdprt)
                var query = conn.query('SELECT `wdprt`, `inout`, `hrs` FROM tcardpu WHERE emailid = ? AND coid = ? AND wdprt LIKE(?)', [emailid, req.userTok.coId, wdprt], function(error1, punch) {
                    cons.log(query.sql)
                    cons.log(error1)
                    var query2 = conn.query('SELECT `wdprt`, `job`, `cat`, `hrs` FROM tcardjc WHERE emailid = ? AND coid = ? AND wdprt LIKE(?)', [emailid, req.userTok.coId, wdprt], function(error2, jcost) {
                        cons.log(query2.sql)
                        cons.log(error2)
                        cons.log(jcost)
                        cons.log(punch)
                        var q = conn.query('SELECT `job`, `category` FROM jobcatact WHERE week=? AND coid=? ORDER BY idx, category', [wk, req.userTok.coId], function(error3, jobs) {
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