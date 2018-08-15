
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
	router.get('/list/:wk', bearerTokenApp, function(req,res){
		if(!req.userTok.auth){
			var mess={message: 'in get /jobs/list (not authorized)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			cons.log(req.userTok);
			cons.log('in /jobs/list no params')
			var q =conn.query('SELECT * FROM jobcatact WHERE week=? AND coid=? ORDER BY idx, category', [req.params.wk, req.userTok.coid ], function(error, results, fields){
				cons.log(q.sql)
				var arrres = results.map((res)=>res)
				res.jsonp({jobs:arrres,binfo:req.userTok})
			})
		}
	})	
	return router
}
