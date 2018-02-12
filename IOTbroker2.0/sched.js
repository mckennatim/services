var moment = require('moment-timezone');
var cons = require('tracer').console();
var my=require('./mysqldb')

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

const findNowAtSpot = (spot)=>{
  var dow = moment().tz(spot).isoWeekday()
  var nynf = parseInt(moment().tz(spot).format("X"))
  var nyf = moment().tz(spot).format('LLLL')
  var nyz = parseInt(moment().tz(spot).format('Z'))  
  var mysql =moment().tz(spot).format("YYYY-MM-DD HH:mm")
  var pkt = {
  	dow: dow,
  	unix: nynf,
  	LLLL: nyf,
  	zone: nyz,
  	mysql:mysql
  };
  return pkt	
}

const findNowAtDev = (devid, cb)=>{
	my.dbGetTimezone(devid, (spot)=>{
		var timeobj = findNowAtSpot(spot)
		cb(timeobj)
	})
}

const sendTimeToDevice = (timeobj, devid, mosca)=>{
	var topi = devid+'/devtime'
	var oPacket = {
		topic: topi,
		payload: JSON.stringify(timeobj),
		retain: false,
		qos: 0
  };
  mosca.publish(oPacket, function(){
  	console.log('just published devtime')
  });
}

//test in atest.spec.js
const updateTime = (devid, mosca, cb)=>{
	findNowAtDev(devid, (timeobj)=>{
		sendTimeToDevice(timeobj, devid, mosca)
		cb(timeobj)
	})
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

const combineScheds=(holdsched, daymin, resumesched)=>{
  let holdarr = JSON.parse(holdsched)
  let resuarr = JSON.parse(resumesched)
	let hrmin = daymin.split(':')
	let hr=hrmin[0]*1
	let min =hrmin[1]*1
  let srdlen=holdarr[0].length - 2
	let res= holdarr.slice()
  resuarr.map((prg,i)=>{
    if(prg[0]==hr){
      let np = [hr, min].concat(prg.slice(-srdlen))
      res.push(np)
    }else if(prg[0]>hr){
      let tmp = resuarr[i-1]
      if (tmp[0]<hr){
        tmp[0]=hr
        tmp[1]=min
        res.push(tmp)
      }
      res.push(prg)
    }
  })
	let resstr = JSON.stringify(res)
	return resstr
}

const modSchedIfHoldEndsToday=(devid, timeobj,res, cb)=>{
  var nowd = timeobj.mysql.split(' ')
  var hldd = res.until.split(' ')
  var sched=res.sched
  if(hldd[0]==nowd[0]){
    var sched
    my.getSenRelSched(devid, res.senrel , timeobj.dow, (resumesched)=>{
      sched = combineScheds(res.sched, timeobj.mysql, resumesched)
    })
  } 
  cb(sched)
}

var setTimeAndSched = (devid,mosca,cb)=>{
	updateTime(devid, mosca, (timeobj)=>
		findSched(timeobj.dow, devid,(results)=>{
			if(results.length>0){
	  		results.map((res)=>{
	  			modSchedIfHoldEndsToday(devid,timeobj, res, (sched)=>{
            var payload = `{"id":${res.senrel},"pro":${sched}}`
            setTimeout(function(){
              sendSched(payload, devid, mosca)
            }, 200)     
          })
				})
			}
      cb('good')
		})
	)
}

module.exports ={
	flattenProgObj: flattenProgObj,
	parseProg: parseProg,
	updateTime: updateTime,
	setTimeAndSched: setTimeAndSched,
	findNowAtSpot: findNowAtSpot,
	findNowAtDev: findNowAtDev,
	findSched: findSched,
	modSchedIfHoldEndsToday: modSchedIfHoldEndsToday,
	combineScheds: combineScheds
}