var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerToken = require('../regtokau/strategy').bearerToken
var cfg = require('../../utilities').cfg
var Reco = require('../../db/models').Reco

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
			var q=conn.query('SELECT * FROM user_app_loc WHERE userid =? AND devid IS NOT null AND (role="admin" OR role="super")', req.userTok.emailId, function (error, results, fields) {
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
	router.get('/loclist', bearerToken, function(req,res){
		if(!req.userTok.auth){
			//console.log(req.userTok.message)
			var mess={message: 'in get /dedata/locids (not authoried)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			cons.log(req.userTok);
			cons.log('in /dedata/loclist no params')
			var q =conn.query('SELECT DISTINCT locid FROM `user_app_loc` WHERE userid=? AND appid=? ORDER BY `locid` ASC', [req.userTok.emailId, req.userTok.appId] , function(error, results, fields){
				cons.log(q.sql)
				var arrres = results.map((loc)=>loc.locid)
				res.jsonp(arrres)
			})
		}
	})
	router.get('/loc/:locid', bearerToken, function(req,res){
		if(!req.userTok.auth){
			//console.log(req.userTok.message)
			var mess={message: 'in get /dedata/loc/:locid (not authoried)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			console.log('in /dedata/loc/:locid', req.params)
			var q =conn.query('SELECT devid FROM `user_app_loc` WHERE userid=? AND appid=? AND locid=?', [req.userTok.emailId, req.userTok.appId, req.params.locid] , function(error, results, fields){
				cons.log(q.sql)
				console.log(results);
				var arrres = results.map((loc)=>loc.devid)
				res.jsonp(arrres)
			})
		}
	})

	router.get('/users/:devid', bearerToken, function(req,res){
		if(!req.userTok.auth){
			//console.log(req.userTok.message)
			var mess={message: 'in get /dedata/users/:devid (not authoried)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			console.log('in devid/users', req.params)
			var q =conn.query('SELECT userid, bizid, appid, role FROM devuserapp WHERE devid=?', req.params.devid, function(error, results, fields){
					cons.log(q.sql)
					res.jsonp(results)
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
				// var q =conn.query('SELECT devid, devpwd, description, bizid, address, location, timezone, server, specs, owner, apps FROM devices ORDER BY bizid, owner', function(error, results, fields){
				// 	cons.log(q.sql)
				// 	res.jsonp(results)
				// })
				var q =conn.query('SELECT d.devid, d.devpwd, d.description, d.bizid, d.locid, l.address, l.latlng, l.timezone, d.server, d.specs, d.owner, d.apps FROM devs d, locations l WHERE d.locid=l.locid ORDER BY d.devid', function(error, results, fields){
					cons.log(q.sql)
					res.jsonp(results)
				})
			}else{
				res.jsonp(mess)
			}
		}
	})

	router.post('/users', bearerToken, function(req,res){
		cons.log('in post users')
		var mess = 'what up post dedata/users'
		if(!req.userTok.auth){
			//console.log(req.userTok.message)
			mess={message: 'not authoried-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			var pdata=req.body
			cons.log(pdata)
			var query = conn.query('INSERT INTO devuserapp SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
				cons.log(query.sql)
					if (error) {
						throw error;
						console.log({message: error})
					}else{
						console.log(results)
					}
			})
			res.jsonp({message:mess})
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
			var udata={userid:pdata.owner, role:'admin', locid:pdata.locid, devid:pdata.devid}
			var ndata={devid:pdata.devid, devpwd:pdata.devpwd, bizid:pdata.bizid, description:pdata.description, locid:pdata.locid, server:pdata.server, specs:pdata.specs, owner:pdata.owner, apps:pdata.apps }
			var odata={devid:pdata.devid, devpwd:pdata.devpwd, description:pdata.description, bizid:pdata.bizid, address:pdata.address, location:pdata.location, timezone: pdata.timezone, server:pdata.server, specs:pdata.specs,  owner:pdata.owner, apps:pdata.apps }
			var ldata={locid:pdata.locid, address:pdata.address, latlng:pdata.location, timezone: pdata.timezone}
			cons.log(ddata)
			cons.log(udata)
			cons.log(ndata)
			cons.log(odata)
			cons.log(ldata)
			appArr.map((appid)=>{
				var bdata = {bizid: pdata.bizid, appid: appid }
				ddata.appid=appid
				udata.appid=appid
				cons.log(ddata)
				var query1 = conn.query('INSERT INTO devuserapp SET ? ON DUPLICATE KEY UPDATE ?', [ddata,ddata], function(error,results,fields){
						cons.log(query1.sql)
						if (error) {
							throw error;
							cons.log({message: error})
						}else{
							cons.log(results)
						}
				})
				var query2 = conn.query('INSERT INTO bizapp SET ? ON DUPLICATE KEY UPDATE ?', [bdata,bdata], function(error,results,fields){
						cons.log(query2.sql)
						if (error) {
							throw error;
							cons.log({message: error})
						}else{
							cons.log(results)
						}
				})
				var query2a = conn.query('INSERT INTO user_app_loc SET ? ON DUPLICATE KEY UPDATE ?', [udata,udata], function(error,results,fields){
						cons.log(query2a.sql)
						if (error) {
							throw error;
							cons.log({message: error})
						}else{
							cons.log(results)
						}
				})
			})
			// save a new device
			var query = conn.query('INSERT INTO devices SET ? ON DUPLICATE KEY UPDATE ?', [odata,odata], function(error,results,fields){
				cons.log(query.sql)
				if (error) {
					throw error;
					res.jsonp({message: error})
				}else{
					cons.log(results)
				}
			})
			var query1a = conn.query('INSERT INTO locations SET ? ON DUPLICATE KEY UPDATE ?', [ldata,ldata], function(error,results,fields){
					cons.log(query1a.sql)
					if (error) {
						throw error;
						cons.log({message: error})
					}else{
						cons.log(results)
					}
			})			
			var queryn = conn.query('INSERT INTO devs SET ? ON DUPLICATE KEY UPDATE ?', [ndata,ndata], function(error,results,fields){
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
				cons.log(error)
				cons.log(results)
				res.jsonp(results)
			})
		}
	})
	router.post('/rec', bearerToken, function(req,res){
		var messa = 'in post dedata/rec'
		if(!req.userTok.auth){
			//console.log(req.userTok.message)
			var mess={message: 'not authoried-'+req.userTok.message}
			cons.log(messa)
			cons.log(mess)
			res.jsonp(mess)
		}else{
			cons.log(req.body)
			Reco.update(req.body, req.body, {upsert: true}, function(err,result){})
			res.jsonp({message: 'authoried'})
		}
	})
	router.delete('/rec', bearerToken, function(req,res){
		var messa = 'in delete dedata/rec'
		if(!req.userTok.auth){
			//console.log(req.userTok.message)
			var mess={message: 'not authoried-'+req.userTok.message}
			cons.log(messa)
			cons.log(mess)
			res.jsonp(mess)
		}else{
			cons.log(req.body)
			Reco.remove(req.body, function(err,result){})
			res.jsonp({message: 'authoried'})
		}
	})
	return router
}
