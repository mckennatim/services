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
            const job = req.body.persons[0].job
            const keys = Object.keys(req.body.persons[0]).join()+',coid'
            const vals = [req.body.persons.map((j) => {
                let anarr = Object.values(j)
                anarr.push(req.userTok.coid)
                return anarr
            })]
            cons.log('keys: ', keys)
            cons.log('vals: ', vals)
            const upddel = conn.query('DELETE FROM jobcatact WHERE job=? AND coid=? AND week=0', [job, req.userTok.coid], function(err0) {
                cons.log('upddel.sql: ', upddel.sql)
                cons.log('err0: ', err0)
                const updins = conn.query('INSERT INTO jobcatact (' + keys + ') VALUES ? ', vals, function(err) {
                    cons.log('updins.sql: ', updins.sql)
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
            var mess = { message: 'in get /persons/list/:wk (not authorized)-' + req.userTok.message }
            cons.log(mess)
            res.jsonp(mess)
        } else {
            cons.log(req.userTok);
            var q = conn.query('SELECT r.id, r.emailid, r.role, p.`firstmid`, p.`lastname`, p.`street`, p.`city`, p.`st`, p.`zip`, p.`ssn`, p.rate, p.`w4allow`, p.`stallow`, p.`active`, p.`effective`, p.`coid` FROM rolewho r LEFT JOIN persons p ON p.emailid = r.emailid AND p.coid =r.coid WHERE r.coid= ?  ORDER BY p.effective DESC',  req.userTok.coid, function(error, results) {
                cons.log(q.sql)
                cons.log(error)
                var arrres = results.map((res) => res)
                res.jsonp({ persons: arrres, binfo: req.userTok })
            })
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
            const job = req.body.job
            var query1 = conn.query('DELETE FROM jobcatact WHERE job=? AND coid=? AND week=0', [job, req.userTok.coid], function(error, results) {
                cons.log(query1.sql)
                cons.log(error)
                cons.log(results)
                res.jsonp(mess)
            })
        }
    })
    return router
}