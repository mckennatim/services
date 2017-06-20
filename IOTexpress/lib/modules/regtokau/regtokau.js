var express = require('express');
var jwt = require('jwt-simple');
var cons = require('tracer').console();
var env = require('../../../env.json')
var conn = require('../../db/mysqldb')

var cfg= env[process.env.NODE_ENV||'development']
var db = cfg.db
var secret = cfg.secret

var router = express.Router();

module.exports = function() {
	router.get('/', function(req, res) {
		res.jsonp({message: "in root of registration module"})		
	});

	router.post('/auth', function(req, res){
		const payload = jwt.decode(req.body.token, secret)
		cons.log(payload)
		if (payload.email==cfg.super){
			//if you are a superuser add if no there the superuser records
			const superdev = "CYURD14I"
			cons.log('your are a superuser')
			var ins = {devid: superdev, userid:  payload.email, bizid:'sbs', appid: 'superapp', role:'super', auth: true }
			var ins2 = {devid: superdev, userid: payload.email, bizid:'sbs', appid: 'admin', role:'admin', auth: true }
			var ins3 = {devid: superdev, userid: payload.email, bizid:'sbs', appid: payload.appId, role:'admin', auth: true }
			conn.query('INSERT INTO devuserapp SET ? ON DUPLICATE KEY UPDATE ?', [ins,ins] , function (error, results, fields) {
			  if(error) {
			  	console.log(error.code)
			  }else {
			  	console.log(results.insertId);
			  }
			})
			conn.query('INSERT INTO devuserapp SET ? ON DUPLICATE KEY UPDATE ?', [ins2,ins2] , function (error, results, fields) {
			  if(error) {
			  	console.log(error.code)
			  }else {
			  	console.log(results.insertId);
			  }
			})
			conn.query('INSERT INTO devuserapp SET ? ON DUPLICATE KEY UPDATE ?', [ins3,ins3] , function (error, results, fields) {
			  if(error) {
			  	console.log(error.code)
			  }else {
			  	console.log(results.insertId);
			  }
			})
			res.jsonp({auth:true, message: 'authenticated a superuser'});
		}else{
			//see if there are any apps/devices for that user or tell them they are shit outa luck and should contact the bossman to add your email to the system. If there is a record(s) for the user/appid then make auth true for them. If not have them ask to be added. 
			conn.query('SELECT * FROM devuserapp  WHERE userid = ? AND appid = ?', [payload.email, payload.appId], function (error, results, fields) {
				if(results.length==0){
					var mes = {auth:false, message: 'You are not authorized for this app on any device. Contact device owner'}
					cons.log(mes)
					res.jsonp(mes);
				}else{
					//ok we will auth you for this app for whatever devices
					var ins4 = {userid: payload.email, appid: payload.appId}
					var query = conn.query("UPDATE devuserapp SET auth= true WHERE userid = ? AND appid = ?", [payload.email, payload.appId] , function (error, results, fields){
						cons.log(query.sql)
						cons.log(error)
						if(error){
							res.jsonp({auth:false, message: 'Sorry, database error '+ error.code +' occured.'});
						}else{
							cons.log(results)
							res.jsonp({auth:true, message: payload.email +' is authorized for ' + payload.appId, payload:payload});
						}
					})					
				}
			})
		}
	})
	return router;
}

