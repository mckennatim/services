var mysql = require('mysql')
var jwt = require('jwt-simple');
var cons = require('tracer').console();
// var env = require('../../../env.json')
// var cfg= env[process.env.NODE_ENV||'development']
var cfg = require('../../utilities').cfg
var get = require('../../utilities').get
var conn = require('../../db/mysqldb')

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
	var q= conn.query('SELECT * FROM whoapp WHERE emailid= ? AND appid=?', [tokdata.email,tokdata.appId], function (error, results, fields) {
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
		cons.log(results[0].coid)
		req.userTok = {auth: true, message: 'user has apps', emailId: tokdata.email, appId: tokdata.appId, coid:results[0].coid}
		if(tokdata.appId=='builder'){
			req.userTok.baseDevId=results[0].devid
			req.userTok.bizId=results[0].role
		}
		next()
		return
	})
}
module.exports = {bearerTokenApp}
