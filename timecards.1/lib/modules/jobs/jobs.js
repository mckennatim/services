var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
// var bearerTokenApp = require('../regtokau/strategy').bearerTokenApp
var bearerTokenCoid = require('../regtokau/strategy').bearerTokenCoid

var router = express.Router();

module.exports = function() {
    router.get('/', function(req, res) {
        res.jsonp({ message: "in root of jobs module" })
    });
    router.put('/update', bearerTokenCoid, function(req, res) {
        if (!req.userTok.auth) {
            var mess = { message: 'in get /jobs/update (not authorized)-' + req.userTok.message }
            res.jsonp(mess)
        } else {
            mess = { message: 'nothing happenning yet-' }
            const job = req.body.jobs[0].job
            const keys = Object.keys(req.body.jobs[0]).join()+',coid'
            const vals = [req.body.jobs.map((j) => {
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
            var mess = { message: 'in get /jobs/update (not authorized)-' + req.userTok.message }
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
    router.get('/list/:wk', bearerTokenCoid, function(req, res) {
        if (!req.userTok.auth) {
            var mess = { message: 'in get /jobs/list/:wk (not authorized)-' + req.userTok.message }
            cons.log(mess)
            res.jsonp(mess)
        } else {
            cons.log(req.userTok);
            cons.log(req.params)
            var q = conn.query('SELECT * FROM jobcatact WHERE week=? AND coid=? ORDER BY idx, category', [req.params.wk * 1, req.userTok.coid], function(error, results) {
                cons.log(q.sql)
                var arrres = results.map((res) => res)
                res.jsonp({ jobs: arrres, binfo: req.userTok })
            })
        }
    })
    router.post('/post/:wk', bearerTokenCoid, function(req, res) {
        if (!req.userTok.auth) {
            var mess = { message: 'in get /jobs/list (not authorized)-' + req.userTok.message }
            cons.log(mess)
            res.jsonp(mess)
        } else {
            mess = { message: 'nothing happenning yet-' }
            const week = req.params.wk * 1
            cons.log(req.body)
            const keys = Object.keys(req.body.jobs[0]).join()+',coid'
            const vals = [req.body.jobs.map((j) => {
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
            var mess = { message: 'in get /jobs/list (not authorized)-' + req.userTok.message }
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