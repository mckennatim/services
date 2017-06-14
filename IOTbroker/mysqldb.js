var mysql      = require('mysql');
var env = require('./env.json')
var cfg= env[process.env.NODE_ENV||'development']
//console.log(cfg.mysql)
var conn = mysql.createConnection(cfg.mysql);

const dbAuth = (clientid, username,password, cb)=>{
	console.log(clientid, username, password)
	if(clientid.substr(0,2)=="CY"){
		console.log('is a device')
		var query=conn.query("SELECT devid, devpwd, owner FROM devices WHERE devid=?", clientid, function(error,results,fields){
			console.log(query.sql)
			console.log(results)
			if(error){
				cb(false)
			}else {
				var res = results[0];
				if(res.devid==clientid && res.owner==username && res.devpwd==password){
					cb(true)
				} else {
					cb(false)
				}
			}
		})
	}else{
		console.log('is a client')
		cb(true)
	}
}

module.exports = {
	cfg: cfg,
	conn: conn,
	dbAuth: dbAuth
}