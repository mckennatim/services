
var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerTokenApp = require('../regtokau/strategy').bearerTokenApp
var cfg = require('../../utilities').cfg
var Reco = require('../../db/models').Reco

var router = express.Router();

module.exports = function() {
	router.get('/', function(req, res) {
		res.jsonp({message: "in root of jobs module"})
	});
	router.get('/test2/:wk', function(req, res) {
		var mess={message: 'nothing happenning yet-'}
			const aj = { jobs:
				[ { job: 'Marketting',
					category: null,
					active: 0,
					week: 19,
					idx: 1,
					coid: 'reroo' },
				  { 
					job: 'Nursery',
					category: null,
					active: 1,
					week: 19,
					idx: 2,
					coid: 'reroo' },
				  { 
					job: 'Truck and tools',
					category: null,
					active: 0,
					week: 19,
					idx: 3,
					coid: 'reroo' }	
				]
			}
			console.log(aj.jobs[0]);
			const coid = aj.jobs[0].coid;
			const week = req.params.wk
			const keys = Object.keys(aj.jobs[0]).join()
			const vals = [aj.jobs.map((j)=>Object.values(j))]		
			console.log(keys);
			console.log(vals);
			var query1 = conn.query('DELETE FROM jobcatact WHERE week=? AND coid = ?', [week,coid], function(error,results,fields){
				cons.log(query1.sql)
				cons.log(error)
				cons.log(results)
				var query = conn.query('INSERT INTO jobcatact ('+keys+') VALUES ? ', vals, function(error,results,fields){
					cons.log(query.sql)
					cons.log(error)
					cons.log(results)
					cons.log(mess)
					res.jsonp(mess)
				})					
			})			
	});
	router.get('/list/:wk', bearerTokenApp, function(req,res){
		if(!req.userTok.auth){
			var mess={message: 'in get /jobs/list (not authorized)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			cons.log(req.userTok);
			cons.log(req.params)
			var q =conn.query('SELECT * FROM jobcatact WHERE week=? AND coid=? ORDER BY idx, category', [req.params.wk, req.userTok.coId ], function(error, results, fields){
				cons.log(q.sql)
				var arrres = results.map((res)=>res)
				res.jsonp({jobs:arrres,binfo:req.userTok})
			})
		}
	})	
	router.post('/post/:wk', bearerTokenApp, function(req,res){
		if(!req.userTok.auth){
			var mess={message: 'in get /jobs/list (not authorized)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			var mess={message: 'nothing happenning yet-'}
			console.log(aj.jobs[0]);
			const week = req.params.wk
			const keys = Object.keys(aj.jobs[0]).join()
			const vals = [aj.jobs.map((j)=>Object.values(j))]		
			console.log(keys);
			console.log(vals);
			var query1 = conn.query('DELETE FROM jobcatact WHERE week=?', week, function(error,results,fields){
				cons.log(query1.sql)
				cons.log(error)
				cons.log(results)
				var query = conn.query('INSERT INTO jobcatact ('+keys+') VALUES ? ', vals, function(error,results,fields){
					cons.log(query.sql)
					cons.log(error)
					cons.log(results)
					cons.log(mess)
					res.jsonp(mess)
				})					
			})
		}	
	})
	return router
}
