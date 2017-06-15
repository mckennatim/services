var mysql      = require('mysql');
var jwt = require('jwt-simple');
var cons = require('tracer').console();
var env = require('./env.json')
var cfg= env[process.env.NODE_ENV||'development']
//console.log(cfg.mysql)
var conn = mysql.createConnection(cfg.mysql);

const dbAuth = (client, username,password, cb)=>{
	console.log(client.id, username, password)
	if(client.id.substr(0,2)=="CY"){
		console.log('is a device')
		var query=conn.query("SELECT devid, devpwd, owner FROM devices WHERE devid=?", client.id, function(error,results,fields){
			console.log(query.sql)
			console.log(results)
			if(error){
				cb(false)
			}else {
				var res = results[0];
				if(res.devid==client.id && res.owner==username && res.devpwd==password){
					cb(true)
				} else {
					cb(false)
				}
			}
		})
	}else{
		cons.log('is a client')
		var clientid= client.id.split('0.')[0]
		var tokdata = jwt.decode(password, cfg.secret)
		cons.log(clientid)
		cons.log(username)
		cons.log(tokdata)
		if(tokdata.appId==clientid && tokdata.email==username){
			cons.log('should be true')
			client.appId= tokdata.appId
			cons.log(client.appId)
			cb(true)
		}else{
			cb(false)
		}
	}
}

const dbPubSub=(inp, cb)=>{
  var query = conn.query("SELECT * FROM devuserapp WHERE devid=? AND appid=? AND userid=?",inp , function(error,results,fields){
    cons.log(query.sql)
    cons.log(results[0])
		if(error){
			cb(false)
		}else {
			var res = results[0];
			if(res.auth){
				cb(true)
			} else {
				cb(false)
			}
		}    
  })	
}

module.exports = {
	cfg: cfg,
	conn: conn,
	dbAuth: dbAuth,
	dbPubSub: dbPubSub
}