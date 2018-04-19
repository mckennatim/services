var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerTokenApp = require('../regtokau/strategy').bearerTokenApp
var cfg = require('../../utilities').cfg
var Reco = require('../../db/models').Reco

var router = express.Router();

module.exports = function() {
	router.get('/', function(req, res) {
		res.jsonp({message: "in root of admin module"})
	});
	router.get('/devlist', bearerTokenApp, function(req,res){
		if(!req.userTok.auth){
			var mess={message: 'in get /admin/devlist (not authoried)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			cons.log(req.userTok);
			cons.log('in /dedata/loclist no params')
			var q =conn.query('SELECT devid FROM devs ORDER BY devid',  function(error, results, fields){
				cons.log(q.sql)
				var arrres = results.map((dev)=>dev.devid)
				res.jsonp(arrres)
			})
		}
	})
	router.get('/dev/:devid', bearerTokenApp, function(req,res){
		if(!req.userTok.auth){
			var mess={message: 'in get /admin/devlist (not authoried)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			console.log('in /admin/dev/:devid', req.params)
			cons.log(req.userTok);
			var q =conn.query('SELECT id,devid,description,specs FROM devs WHERE devid=?', req.params.devid, function(error, results, fields){
				cons.log(q.sql)
				res.jsonp(results)
			})
		}
	})	
	return router
}
