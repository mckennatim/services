var mysql      = require('mysql');
var jwt = require('jwt-simple');
var cons = require('tracer').console();
var ut = require('./utility')
var env = require('./env.json')
var cfg= env[process.env.NODE_ENV||'development']
//console.log(cfg.mysql)
var conn = mysql.createConnection(cfg.mysql);

//cons.log(ut.cfg)

const dbAuth = (client, username,password, cb)=>{
	console.log(client.id, username, password)
	if(client.id.substr(0,2)=="CY"){
		console.log('is a device')
		var query=conn.query("SELECT devid, devpwd, owner FROM devices WHERE devid=?", client.id, function(error,results,fields){
			console.log(query.sql)
			console.log(results)
			console.log(error)
			if(error){
				cb(false)
			}else {
				var res = results[0];
				if(ut.get('res.devid',res)==client.id && ut.get('res.owner',res)==username && ut.get('res.devpwd',res)==password){
					cb(true)
				} else {
					cb(false)
				}
			}
		})
	}else{
		cons.log('is a client')
		var clientid= client.id.split('0.')[0]
		if(password){
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
		}else{
			cb(false)
		}
	}
}
var mcache={inp:["", "", ""], res:false}

const dbSubscr=(inp, cb)=>{
	// cons.log(inp)
	if(inp[2]==cfg.super){
		cb(true)
		return
	}
	if(inp.every((v,i)=>v===mcache.inp[i])){
		// cons.log(mcache)
		cb(mcache.res)
		return
	}
  var query = conn.query("SELECT * FROM devuserapp WHERE devid=? AND appid=? AND userid=?",inp , function(error,results,fields){
    cons.log(query.sql)
    //cons.log(results[0])
    var cbv=false
		if(error){
			cbv= false
		}else {
			var res = results[0];
			if(ut.get('res.auth', res)){
				cbv=true
			} else {
				cbv=false
			}
		}
		mcache.inp = inp.slice()
		mcache.res = cbv
		cb(cbv)    
  })	
}

var pcache={inp:["", "", ""], res:false}
const dbPublish=(inp, cb)=>{
	cons.log(inp)
	if(inp[2]==cfg.super){
		cb(true)
		return
	}	
	// if(inp.every((v,i)=>v===pcache.inp[i])){
	// 	//cons.log('using CACHE')
	// 	cb(pcache.res)
	// 	return
	// }
  var query = conn.query("SELECT * FROM devuserapp WHERE devid=? AND appid=? AND userid=?",inp , function(error,results,fields){
    cons.log(query.sql)
    var cbv=false
		if(error){
			cbv=false
		}else {
			var res = results[0];
			cons.log(res)
			if(ut.get('res.role',res)=='obs' || ut.get('res.role', res)=='any'){
				cbv=false
			} else {
				cbv=true
			}
		}
		pcache.inp = inp.slice()
		pcache.res = cbv
		cb(cbv)  		    
  })	
}

const dbPubSet=(inp,cb)=>{
	var query = conn.query("SELECT * FROM devuserapp WHERE devid=? AND userid=? and role= 'admin'", inp, function(error,results,fields){
		if(error){
			cb(false)
		}else {
			cons.log(results)
			if(results.length>0){
				cb(true)
			}else{
				cb(false)
			}
		}	
	})
}

const dbGetTimezone=(devId, cb)=>{
	var query=conn.query("SELECT timezone FROM devices WHERE devid=?", devId, function(error,results,fields){
		cons.log(results[0])
		cb(results[0].timezone)	
	})
}

const getTodaysSched=(devid, dow, cb)=>{
	var query=conn.query("SELECT * FROM scheds WHERE devid=? AND dow=?", [devid,dow], function(error,results,fields){
		cons.log(query.sql)
		if (results.length==0){
			//check it there is and everyday program
			var query2=conn.query("SELECT * FROM scheds WHERE devid=? AND dow=0", devid, function(error,results0,fields){
				cb(results0)
			})
		}else{
			cb(results)
		}
	})
}

module.exports = {
	cfg: cfg,
	conn: conn,
	dbAuth: dbAuth,
	dbSubscr: dbSubscr,
	dbPublish: dbPublish,
	dbPubSet: dbPubSet,
	dbGetTimezone: dbGetTimezone,
	getTodaysSched: getTodaysSched
}