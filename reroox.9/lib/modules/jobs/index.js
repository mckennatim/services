var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerTokenApp = require('../regtokau/strategy').bearerTokenApp

var router = express.Router();

module.exports = function() {
    router.get('/', function(req, res) {
        res.jsonp({ message: "in root of jobs module" })
    });
    router.put('/test2', function(req, res) {
        var mess = { message: 'nothing happenning yet-' }
        cons.log(req.body)
        const job = req.body.jobs[0].job
        const coid = req.body.jobs[0].coid
        const keys = Object.keys(req.body.jobs[0]).join()
        const vals = [req.body.jobs.map((j) => Object.values(j))]
        console.log(keys);
        console.log(vals);
        var query1 = conn.query('DELETE FROM jobcatact WHERE job=? AND coid=? AND week=0', [job, coid], function(error, results) {
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
    });
    router.put('/update', bearerTokenApp, function(req, res) {
        if (!req.userTok.auth) {
            var mess = { message: 'in get /jobs/update (not authorized)-' + req.userTok.message }
            cons.log(mess)
            res.jsonp(mess)
        } else {
            mess = { message: 'nothing happenning yet-' }
            cons.log(req.body)
            const job = req.body.jobs[0].job
            const keys = Object.keys(req.body.jobs[0]).join()
            const vals = [req.body.jobs.map((j) => Object.values(j))]
            console.log(keys);
            console.log(vals);
            var query1 = conn.query('DELETE FROM jobcatact WHERE job=? AND coid=? AND week=0', [job, req.userTok.coId], function(error, results) {
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
    });
    router.put('/new', bearerTokenApp, function(req, res) {
        if (!req.userTok.auth) {
            var mess = { message: 'in get /jobs/new (not authorized)-' + req.userTok.message }
            cons.log(mess)
            res.jsonp(mess)
        } else {
            mess = { message: 'nothing happenning yet-' }
            cons.log(req.body)
            const keys = Object.keys(req.body.jobs[0]).join()
            const vals = [req.body.jobs.map((j) => Object.values(j))]
            console.log(keys);
            console.log(vals);
            var query = conn.query('INSERT INTO jobcatact (' + keys + ') VALUES ? ', vals, function(error, results) {
                cons.log(query.sql)
                cons.log(error)
                cons.log(results)
                cons.log(mess)
                res.jsonp(mess)
            })
        }
    });    
    router.get('/list/:wk', bearerTokenApp, function(req, res) {
        if (!req.userTok.auth) {
            var mess = { message: 'in get /jobs/list (not authorized)-' + req.userTok.message }
            cons.log(mess)
            res.jsonp(mess)
        } else {
            cons.log(req.userTok);
            cons.log(req.params)
            var q = conn.query('SELECT * FROM jobcatact WHERE week=? AND coid=? ORDER BY idx, category', [req.params.wk * 1, req.userTok.coId], function(error, results) {
                cons.log(q.sql)
                var arrres = results.map((res) => res)
                res.jsonp({ jobs: arrres, binfo: req.userTok })
            })
        }
    })
    router.post('/post/:wk', bearerTokenApp, function(req, res) {
        if (!req.userTok.auth) {
            var mess = { message: 'in get /jobs/list (not authorized)-' + req.userTok.message }
            cons.log(mess)
            res.jsonp(mess)
        } else {
            mess = { message: 'nothing happenning yet-' }
            const week = req.params.wk * 1
            cons.log(req.body)
            const keys = Object.keys(req.body.jobs[0]).join()
            const vals = [req.body.jobs.map((j) => Object.values(j))]
            console.log(keys);
            console.log(vals);
            var query1 = conn.query('DELETE FROM jobcatact WHERE week=? AND coid=?', [week, req.userTok.coId], function(error, results) {
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
    router.delete('/del', bearerTokenApp, function(req, res) {
        if (!req.userTok.auth) {
            var mess = { message: 'in get /jobs/list (not authorized)-' + req.userTok.message }
            cons.log(mess)
            res.jsonp(mess)
        } else {
            mess = { message: 'nothing happenning yet-' }
            cons.log(req.body)
            const job = req.body.job
            var query1 = conn.query('DELETE FROM jobcatact WHERE job=? AND coid=? AND week=0', [job, req.userTok.coId], function(error, results) {
                cons.log(query1.sql)
                cons.log(error)
                cons.log(results)
                res.jsonp(mess)
            })
        }
    })
    return router
}