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
		var query=conn.query("SELECT devid, devpwd, owner FROM devs WHERE devid=?", client.id, function(error,results,fields){
			cons.log(query.sql)
			cons.log(results)
			cons.log(error)
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
		if(username=='anybody'){
			cons.log('ck if anybody is allowed')
			var query = conn.query("SELECT * FROM user_app_loc WHERE appid=? AND userid=?",[clientid, username] , function(error,results,fields){
				cons.log(query.sql)
				if(results[0] && results[0].role=='obs'){
					cons.log('anybody is allowed as obs')
					cb(true)
				}else{
					cons.log('anybody is not allowed')
					cb(false)
				}
			})
		}else if(password){
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
	cons.log(inp)
	if(inp[2]==cfg.super){
		cb(true)
		return
	}
	// if(inp.every((v,i)=>v===mcache.inp[i])){
	// 	// cons.log(mcache)
	// 	cb(mcache.res)
	// 	return
	// }
  var query = conn.query("SELECT * FROM user_app_loc WHERE devid=? AND appid=? AND userid=?",inp , function(error,results,fields){
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
		// mcache.inp = inp.slice()
		// mcache.res = cbv
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
  var query = conn.query("SELECT * FROM user_app_loc WHERE devid=? AND appid=? AND userid=?",inp , function(error,results,fields){
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
const dbGetUser=(params,cb)=>{
	cons.log(params)
  if(params[2]==cfg.super){
  	cb(true)
  	return
 	}	
	var query = conn.query("SELECT * FROM user_app_loc WHERE devid=? AND appid=? AND (userid=? OR userid='anybody')",params , function(error,results,fields){
    cons.log(query.sql)
    //cons.log(results)
    var cbv=false
		if(error){
			cbv=false
		}else if(results.length>0) {
			results.map((x)=>{
				if(x.role=='user' || x.role=='admin'){
					cbv=true
				}
			})
		} else{
			cbv=false
		}
		//cons.log(cbv)
		cb(cbv)    
  })

}

const dbPubSet=(inp,cb)=>{
	var query = conn.query("SELECT * FROM user_app_loc WHERE devid=? AND userid=? and role= 'admin'", inp, function(error,results,fields){
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
	var query=conn.query("SELECT l.timezone FROM locations l, devs d WHERE l.locid=d.locid AND d.devid=?", devId, function(error,results,fields){
		cb(results[0].timezone)	
	})
}

	/*
	first there is the inner query which groups by senrel taking only the max dow which eliminates dow=0 values when there is a record for the actual dow. The inner join is used to filter all the records to just take that.
	SELECT * FROM scheds a
	INNER JOIN (SELECT MAX(dow)as mdow, senrel 
		FROM scheds
		WHERE devid='CYURD002' AND (dow=2 OR dow=0) 
		GROUP BY senrel)b
	ON a.dow=b.mdow AND a.senrel=b.senrel

	SELECT * FROM scheds a INNER JOIN (SELECT MAX(dow)as mdow, senrel FROM scheds WHERE devid=? AND (dow=? OR dow=0) GROUP BY senrel)b ON a.dow=b.mdow AND a.senrel=b.senrel
	*/
	//var query=conn.query("SELECT * FROM scheds WHERE devid=? AND (dow=? OR dow=0) ORDER BY dow", [devid,dow], function(error,results,fields){
const getTodaysSched=(devid, timeobj, cb)=>{
	let dow = timeobj.dow
	let myuntil = timeobj.mysql.split(' ')[0]
	var query=conn.query("SELECT * FROM scheds WHERE (devid,senrel,dow) IN ( SELECT devid, senrel, MAX(dow) FROM scheds WHERE (dow=0 OR dow=? OR dow=8) AND (until = '0000-00-00 00:00' OR ? <= until) GROUP BY devid, senrel ) AND devid = ?", [dow,myuntil,devid], function(error,results,fields){
		cons.log(query.sql)
		cons.log(results)
		cb(results)
	})
}

const getSenRelSched=(devid,senrel,dow,cb)=>{
	var query=conn.query("SELECT * FROM scheds WHERE devid= ? AND senrel=? AND (dow=0 OR dow=?) ORDER BY dow DESC LIMIT 0,1 ", [devid, senrel, dow], function(error,results,fields){
		cons.log(query.sql)
		cons.log(results)
		cb(results)
	})	
}

module.exports = {
	cfg: cfg,
	conn: conn,
	dbAuth: dbAuth,
	dbSubscr: dbSubscr,
	dbPublish: dbPublish,
	dbPubSet: dbPubSet,
	dbGetUser: dbGetUser,
	dbGetTimezone: dbGetTimezone,
	getTodaysSched: getTodaysSched,
	getSenRelSched: getSenRelSched
}