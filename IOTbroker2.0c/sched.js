var moment = require('moment-timezone');
var cons = require('tracer').console();
var my=require('./mysqldb')

//console.log(moment.tz.names())
var cb=function(){
	console.log("in cb")
}

var flattenProgObj =function(progs){	
	a=[]
	progs.map(function(prog, idx){
		prog.wk.map(function(w,ix){
			w.map(function(x){
				za = {};
				za.senrel = prog.senrel
				za.day = ix
				x.map(function(y,i){
					switch(i){
						case 0:
							za.hour=y
							break;
						case 1:
							za.min=y
							break;
						case 2:
							za.val=y
							break;
					}
				})
				a.push(za)
			})
		})
	})
	return a
}

var parseProg =function(prog){
	console.log(prog)
}

const sendTimeToDevice = (spot, devid, mosca, cb)=>{
  var dow = moment().tz(spot).isoWeekday()
  var nynf = parseInt(moment().tz(spot).format("X"))
  var nyf = moment().tz(spot).format('LLLL')
  var nyz = parseInt(moment().tz(spot).format('Z'))  
  var pkt = {
  	unix: nynf,
  	LLLL: nyf,
  	zone: nyz,
  };	
	var topi = devid+'/devtime'
	var oPacket = {
		topic: topi,
		payload: JSON.stringify(pkt),
		retain: false,
		qos: 0
  };
  mosca.publish(oPacket, function(){
  	console.log('just published devtime')
  });
  cb(dow)			
}

//test in atest.spec.js
const updateTime = (devid, mosca, cb)=>{
	my.dbGetTimezone(devid, (spot)=>
		sendTimeToDevice(spot, devid, mosca, (dow)=>
			cb(dow)
		)
	)
}


const findSched = (dow, devid,cb)=>{
	my.getTodaysSched(devid,dow,function(results){
		cb(results)
	})
}

const sendSched= (sched, devid, mosca)=>{
	var topi = devid+'/prg'
	var oPacket = {
		topic: topi,
		payload: sched,
		retain: false,
		qos: 0
  };
  mosca.publish(oPacket, ()=>{
  	console.log('prg sent')
  });	
}

var getTimeAndSched = (devid,mosca,cb)=>{
	updateTime(devid, mosca, (dow)=>
		findSched(dow, devid,(results)=>{
  		results.map((res)=>{
  			var payload = `{"id":${res.senrel},"pro":${res.sched}}`
				setTimeout(function(){
					sendSched(payload, devid, mosca)
				}, 1000)			
				cb(results)
			})
		})
	)
}

var getTime = function(devid, mosca, cb){
  //var spot="America/Los_Angeles"
  my.dbGetTimezone(devid, function(spot){
	  console.log(spot)
	  var dow = moment().tz(spot).isoWeekday()
	  var nynf = parseInt(moment().tz(spot).format("X"))
	  var nyf = moment().tz(spot).format('LLLL')
	  var nyz = parseInt(moment().tz(spot).format('Z'))  
	  var pkt = {
	  	unix: nynf,
	  	LLLL: nyf,
	  	zone: nyz,
	  };	
		console.log(JSON.stringify(pkt))
		var topi = devid+'/devtime'
		var oPacket = {
			topic: topi,
			payload: JSON.stringify(pkt),
			retain: false,
			qos: 0
	  };
	  cons.log(topi) 
	  mosca.publish(oPacket, function(){
	  	cons.log('just published devtime')
	  	//var topic = devid+'/prg'
	  });	  	
  	my.getTodaysSched(devid,dow,function(results){
  		cons.log('dow is ', dow)
  		results.map((res)=>{
  			//cons.log(res)
  			var payload = `{"id":${res.senrel},"pro":${res.sched}}`
  			//cons.log(payload)
				setTimeout(function(){
					sendSchedule(devid, mosca, payload, (payload)=>{
						cons.log(payload, ' sent')
					})
				}, 1000)	  			
  		})
  	})

	})
}


var sendSchedule= function(devid, mosca, payload, cb){
	var topi = devid+'/prg'
	var oPacket = {
		topic: topi,
		payload: payload,
		retain: false,
		qos: 0
  };
  mosca.publish(oPacket, ()=>{
  	cons.log('prg sent')
  });		
}

module.exports ={
	flattenProgObj: flattenProgObj,
	parseProg: parseProg,
	getTime: getTime,
	sendSchedule: sendSchedule,
	updateTime: updateTime,
	getTimeAndSched: getTimeAndSched
}