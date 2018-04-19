var mysql = require('mysql')
var jwt = require('jwt-simple');
var cons = require('tracer').console();
// var env = require('../../../env.json')
// var cfg= env[process.env.NODE_ENV||'development']
var cfg = require('../../utilities').cfg
var get = require('../../utilities').get
var conn = require('../../db/mysqldb')


var bearerToken = function(req,res, next){
	if(!get('req.headers.authorization', req)){
		req.userTok = {auth: false, message: "no authorization header", emailId: ""}
		next()
		return
	}
	var toka = req.headers.authorization.split(' ')
	cons.log(toka[1])
	try {
		var tokdata = jwt.decode(toka[1], cfg.secret)
		cons.log(tokdata)
	} catch(e){
		cons.log(e.message)
		req.userTok = {auth: false, message: e.message, emailId: ""}
		next()
		return
	}
	//cons.log(tokdata)
	var retu = 'duch'
	var q= conn.query('SELECT userid, devid FROM user_app_loc WHERE userid= ? AND devid IS NOT null', tokdata.email, function (error, results, fields) {
		cons.log(q.sql)
		if (error){
			cons.log(error.message)
			req.userTok = {auth: false, message: error.message}
			next()
			return
		}
		cons.log(results.length)
		if(!results){
			req.userTok = {auth: false, message: 'no user'}
			next()
			return
		}
		if(results.length>0){
			if(results.length==1 & results[0].devid==null){
				req.userTok = {auth: true, message: 'no apps', emailId: tokdata.email}
				next()
			}else{
				req.userTok = {auth: true, message: 'user has apps', emailId: tokdata.email, appId: tokdata.appId}
				next()
			}
		}else{
			req.userTok = {auth: false, message: 'no user'}
			next()
		}
	})
}

var bearerTokenApp = function(req,res, next){
	if(!get('req.headers.authorization', req)){
		req.userTok = {auth: false, message: "no authorization header", emailId: ""}
		next()
		return
	}
	var toka = req.headers.authorization.split(' ')
	cons.log(toka[1])
	try {
		var tokdata = jwt.decode(toka[1], cfg.secret)
		cons.log(tokdata)
	} catch(e){
		cons.log(e.message)
		req.userTok = {auth: false, message: e.message, emailId: ""}
		next()
		return
	}
	cons.log(tokdata)
	var retu = 'duch'
	var q= conn.query('SELECT userid, devid FROM user_app_loc WHERE userid= ? AND appid=?', [tokdata.email,tokdata.appId], function (error, results, fields) {
		cons.log(q.sql)
		if (error){
			cons.log(error.message)
			req.userTok = {auth: false, message: error.message}
			next()
			return
		}
		cons.log(results.length)
		if(!results){
			req.userTok = {auth: false, message: 'no user'}
			next()
			return
		}
		cons.log(results)
		req.userTok = {auth: true, message: 'user has apps', emailId: tokdata.email, appId: tokdata.appId}
		next()
		return
	})
}
module.exports = {bearerToken, bearerTokenApp}
