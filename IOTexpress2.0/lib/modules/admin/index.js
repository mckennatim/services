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
	router.get('/b/devlist', bearerTokenApp, function(req,res){
		if(!req.userTok.auth){
			var mess={message: 'in get /admin/devlist (not authoried)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			cons.log(req.userTok);
			cons.log('in /b/dedata/loclist no params')
			var q =conn.query('SELECT devid FROM devs WHERE owner=? ORDER BY devid',req.userTok.emailId,  function(error, results, fields){
				cons.log(q.sql)
				var arrres = results.map((dev)=>dev.devid)
				res.jsonp({devs:arrres,binfo:req.userTok})
			})
		}
	})
	router.get('/b/dev/:devid', bearerTokenApp, function(req,res){
		if(!req.userTok.auth){
			var mess={message: 'in get /admin/devlist (not authoried)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			console.log('in /admin/dev/:devid', req.params)
			cons.log(req.userTok);
			var q =conn.query('SELECT devid,description,specs,owner FROM devs WHERE devid=? AND owner=?', [req.params.devid,req.userTok.emailId], function(error, results, fields){
				cons.log(q.sql)
				res.jsonp({devinfo:results[0], binfo:req.userTok})
			})
		}
	})	
	router.get('/b/nextdev/:base', bearerTokenApp, function(req,res){
		if(!req.userTok.auth){
			var mess={message: 'in get /admin/devlist (not authoried)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			console.log('in /admin/nextdev', req.params)
			cons.log(req.userTok);
			let likewhat= req.params.base + '%'
			var q =conn.query("SELECT devid FROM devs WHERE devid LIKE ? ORDER BY devid DESC LIMIT 1", likewhat, function(error, results, fields){
				cons.log(q.sql)
				res.jsonp(results[0])
			})
		}
	})	
	router.delete('/b/deldev/:devid', bearerTokenApp, function(req,res){
		if(!req.userTok.auth){
			var mess={message: 'in delete /admin/deldev/device (not authoried)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			console.log('in delete /admin/deldev/device', req.params)
			let email=req.userTok.emailId;
			let devid= req.params.devid 
			var q =conn.query("DELETE FROM devs WHERE devid = ? AND owner = ?", [devid,email], function(error, results, fields){
				cons.log(q.sql)
				res.jsonp(results)
			})
		}
	})	
	router.post('/b/savedev', bearerTokenApp, function(req,res){
		cons.log('in post dev')
		if(!req.userTok.auth){
			var mess={message: 'not authorized-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			var pdata=req.body
			cons.log(pdata)
			var queryn = conn.query('INSERT INTO devs SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
				cons.log(queryn.sql)
				if (error) {
					throw error;
					res.jsonp({message: error})
				}else{
					cons.log(results)
					res.jsonp({message: results})
				}
			})			
		}
	})
	return router
}
