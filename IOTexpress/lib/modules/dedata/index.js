var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerToken = require('../regtokau/strategy').bearerToken
var cfg = require('../../utilities').cfg

var router = express.Router();

module.exports = function() {
	router.get('/', function(req, res) {
		res.jsonp({message: "in root of dedata module"})		
	});
	router.get('/apps', bearerToken, function(req,res){
		if(!req.userTok.auth){
			var mess={auth:false, message: 'in get /dedata/apps (not authoried)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			var q=conn.query('SELECT d.userid, d.devid, e.description as devdesc, d.bizid, d.appid,  a.desc as appdesc, d.role, d.auth FROM `devuserapp` d LEFT JOIN `devices` e ON d.devid=e.devid LEFT JOIN `apps` a ON d.appid=a.appid WHERE d.userid= ?', req.userTok.emailId, function (error, results, fields) {
				cons.log(q.sql)
				//cons.log(results)
				if (error){
					cons.log(error.message)
					res.jsonp = {auth: false, message: error.message}
				}
				cons.log(results.length)
				if(!results){
					res.jsonp = {auth: false, message: 'no user'}
				}
				if(results.length>0){
					if(results.length==1 & results[0].devid==null){
						res.jsonp = {auth: true, message: 'no apps', emailId: req.userTok.emailId}
					}else{
						res.jsonp({auth: true, message: 'user has apps', apps: results, emailId: req.userTok.emailId})
					}
				}else{
					res.jsonp = {auth: false, message: 'no user'}
				}				
			})			
		}
	})
	router.get('/dev', bearerToken, function(req,res){
		if(!req.userTok.auth){
			//console.log(req.userTok.message)
			var mess={message: 'in get /dedata/dev (not authoried)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{		
			var mess = {message:'in get dev(authorized)'}
			var pdata=req.userTok

			cons.log(pdata)
			cons.log(mess.message)
			if(req.userTok.emailId==cfg.super){
				cons.log('yo super')
				var q =conn.query('SELECT * FROM devices ORDER BY bizid, owner', function(error, results, fields){
					cons.log(q.sql)
					res.jsonp(results)
				})
			}else{
				res.jsonp(mess)
			}
		}
	})
	router.post('/dev', bearerToken, function(req,res){
		cons.log('in post dev')
		//cons.log(req.userTok)
		if(!req.userTok.auth){
			//console.log(req.userTok.message)
			var mess={message: 'not authoried-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			var pdata=req.body
			cons.log(pdata)
			var appArr = JSON.parse(pdata.apps)
			var ddata={devid:pdata.devid, userid:pdata.owner, bizid:pdata.bizid, role:'admin'}
			cons.log(ddata)
			cons.log(appArr)
			appArr.map((appid)=>{
				var bdata = {bizid: pdata.bizid, appid: appid }
				ddata.appid=appid
				console.log(ddata)
				var query1 = conn.query('INSERT INTO devuserapp SET ? ON DUPLICATE KEY UPDATE ?', [ddata,ddata], function(error,results,fields){
						if (error) {
							throw error;
							console.log({message: error})
						}else{
							console.log(results)
						}					
				})
				var query2 = conn.query('INSERT INTO bizapp SET ? ON DUPLICATE KEY UPDATE ?', [bdata,bdata], function(error,results,fields){
						if (error) {
							throw error;
							console.log({message: error})
						}else{
							console.log(results)
						}					
				})
			})
			// save a new device
			var query = conn.query('INSERT INTO devices SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
				if (error) {
					throw error;
					res.jsonp({message: error})
				}else{
					console.log(results)
					res.jsonp({message: results})
				}
			})
		}
	})
	router.post('/prg', bearerToken, function(req,res){
		var messa = 'in post dedata/prg'
		if(!req.userTok.auth){
			//console.log(req.userTok.message)
			var mess={message: 'not authoried-'+req.userTok.message}
			cons.log(messa)
			cons.log(mess)
			res.jsonp(mess)
		}else{
			cons.log(req.body)	
			var query = conn.query('INSERT INTO scheds SET ? ON DUPLICATE KEY UPDATE ?', [req.body,req.body], function(error,results,fields){
				cons.log(query.sql)
				cons.log(results)
				res.jsonp(results)
			})
		}
	})
	return router
}