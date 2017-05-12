var mysql = require('mysql')
var jwt = require('jwt-simple');
var cons = require('tracer').console();
var env = require('../../../env.json')
var cfg= env[process.env.NODE_ENV||'development']
var conn = require('../../db/mysqldb')


var bearerToken = function(req,res, next){
	var toka = req.headers.authorization.split(' ')
	try { 
		var tokdata = jwt.decode(toka[1], cfg.secret)
		cons.log(tokdata)
	} catch(e){
		cons.log(e.message)
		req.tokenAuth = {auth: false, message: e.message}
		next()
		return
	} 
	cons.log(tokdata)
	var retu = 'duch'
	conn.query('SELECT * FROM devuserapp  WHERE userid = ?', tokdata.email, function (error, results, fields) {
		if (error){
			cons.log(error.message)
			req.tokenAuth = {auth: false, message: error.message}
			next()
			return
		}
		cons.log(results.length)
		if(!results){
			req.tokenAuth = {auth: false, message: 'no user'}
			next()
			return
		}
		if(results.length>0){
			if(results.length==1 & results[0].devid==null){
				req.tokenAuth = {auth: true, message: 'no apps'}
				next()
			}else{
				var resu =[]
				results.map((result)=>{
					resu.push(Object.assign({}, result))
				})
				cons.log('should be returning results')
				req.tokenAuth = {auth: true, message: 'user has apps', apps: resu}
				next()
			}
		}else{
			req.tokenAuth = {auth: false, message: 'no user'}
			next()
		}	
	})

}

module.exports = {bearerToken}