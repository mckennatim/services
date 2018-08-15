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
		cons.log("in api/reg/auth")
		cons.log(req.body)
		const payload = jwt.decode(req.body.token, secret)
		cons.log(payload)
			var query1= conn.query('SELECT * FROM whoapp  WHERE emailid = ? AND appid = ?', [payload.email, payload.appId], function (error, results, fields) {
				cons.log(query1.sql)
				if(results.length==0){
					var mes = {auth:false, message: 'You are not authorized for this app for this company'}
					cons.log(mes)
					res.jsonp(mes);
				}else{
					//ok we will auth you for this app for whatever devices
					var ins4 = {userid: payload.email, appid: payload.appId}
					var query = conn.query("UPDATE whoapp SET auth= true WHERE emailid = ? AND appid = ?", [payload.email, payload.appId] , function (error, results, fields){
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
		// }
	})
	return router;
}

