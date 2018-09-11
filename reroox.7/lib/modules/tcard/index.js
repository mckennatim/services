
var express = require('express');
var moment = require('moment');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerTokenApp = require('../regtokau/strategy').bearerTokenApp
var cfg = require('../../utilities').cfg
var Reco = require('../../db/models').Reco

var router = express.Router();

module.exports = function() {
	router.get('/', function(req, res) {
		res.jsonp({message: "in root of tcard module"})
	});
	router.get('/test/:wk', function(req, res) {
		const emailid = "tim@sitebuilt.net"
		const wk = req.params.wk
		const yr= moment().format('YYYY')
		const wdprt = `${yr}-W${wk.toString().padStart(2,'0')}%`
		cons.log(wdprt)
		var query = conn.query('SELECT * FROM tcardpu WHERE emailid = ? AND wdprt LIKE(?)',[emailid,wdprt], function(error,punch,fields){
			cons.log(query.sql)
			cons.log(error)
			var query2 = conn.query('SELECT * FROM tcardjc WHERE emailid = ? AND wdprt LIKE(?)',[emailid,wdprt], function(error2,jcost,fields2){
				cons.log(query2.sql)
				cons.log(error2)
				cons.log(jcost)
				cons.log(punch)
				res.jsonp({punch:punch, jcost:jcost})		
			})
		})
	});
	router.put('/update',bearerTokenApp,  function(req, res) {
		if(!req.userTok.auth){
			var mess={message: 'in get /tcard/update (not authorized)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			cons.log(req.body)
			const {wdprt, hrs, inout, jcost}= req.body.tday
			const pdata ={wdprt: wdprt, emailid: req.userTok.emailId, inout: JSON.stringify(inout), hrs: hrs, coid: req.userTok.coId}
			var query0 = conn.query('INSERT INTO tcardpu SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
				cons.log(query0.sql)
				cons.log(error)
				cons.log(results)
				let jcdata = {wdprt: wdprt, emailid: req.userTok.emailId, coid: 		req.userTok.coId}
				var query1 = conn.query('DELETE FROM tcardjc WHERE wdprt=? AND emailid=? AND coid=? ', [wdprt, req.userTok.emailId, req.userTok.coId], function(error,results,fields){
					cons.log(query1.sql)
					cons.log(error)
					jcost.map((jc)=>{
						jcdata.job=jc.job
						jcdata.cat=jc.cat
						jcdata.hrs=jc.hrs
						var query2 = conn.query('INSERT INTO tcardjc SET ? ', jcdata, function(error,results,fields){
							cons.log(query2.sql)
							cons.log(error)
							cons.log(results)
						})
					})
					res.jsonp(req.body)
				})
			})
		}
	})
	router.put('/updjc',bearerTokenApp,  function(req, res) {
		if(!req.userTok.auth){
			var mess={message: 'in get /tcard/updjc (not authorized)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			cons.log(req.body)
			const {wdprt, jcost}= req.body.tday
			let jcdata = {wdprt: wdprt, emailid: req.userTok.emailId, coid: 		req.userTok.coId}
			var query = conn.query('DELETE FROM tcardjc WHERE wdprt=? AND emailid=? AND coid=? ', [wdprt, req.userTok.emailId, req.userTok.coId], function(error,results,fields){
				cons.log(query.sql)
				cons.log(error)
				jcost.map((jc)=>{
					jcdata.job=jc.job
					jcdata.cat=jc.cat
					jcdata.hrs=jc.hrs
					var query2 = conn.query('INSERT INTO tcardjc SET ? ', jcdata, function(error,results,fields){
						cons.log(query2.sql)
						cons.log(error)
						cons.log(results)
					})
				})
				res.jsonp({message:'updated tcardjc data'})
			})
		}
	})	
	router.put('/updpu',bearerTokenApp,  function(req, res) {
		if(!req.userTok.auth){
			var mess={message: 'in get /tcard/updpu (not authorized)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			cons.log(req.body)
			const {wdprt, hrs, inout}= req.body.tday
			const pdata ={wdprt: wdprt, emailid: req.userTok.emailId, inout: JSON.stringify(inout), hrs: hrs, coid: req.userTok.coId}
			var query = conn.query('INSERT INTO tcardpu SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
				cons.log(query.sql)
				cons.log(error)
				cons.log(results)
				res.jsonp(req.body)
			})
		}
	})	
	router.put('/updstat',bearerTokenApp,  function(req, res) {
		if(!req.userTok.auth){
			var mess={message: 'in get /tcard/updstat (not authorized)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			const pdata = req.body.wkstat
			pdata.emailid = req.userTok.emailId
			pdata.coid = req.userTok.coId
			
			var query = conn.query('INSERT INTO tcardwk SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
				cons.log(query.sql)
				cons.log(error)
				cons.log(results)				
				res.jsonp(pdata)
			})
		}
	})
	router.get('/bweek/:wk', bearerTokenApp, function(req, res) {
		if(!req.userTok.auth){
			var mess={message: 'in get /jobs/update (not authorized)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{	
			const wk = req.params.wk
			const yr= moment().format('YYYY')
			const wdprt = `${yr}-W${wk.toString().padStart(2,'0')}%`
			cons.log(wdprt)
			var query = conn.query('SELECT `wdprt`, `inout`, `hrs` FROM tcardpu WHERE emailid = ? AND coid = ? AND wdprt LIKE(?)',[req.userTok.emailId, req.userTok.coId, wdprt], function(error,punch,fields){
				cons.log(query.sql)
				cons.log(error)
				var query2 = conn.query('SELECT `wdprt`, `job`, `cat`, `hrs` FROM tcardjc WHERE emailid = ? AND coid = ? AND wdprt LIKE(?)',[req.userTok.emailId, req.userTok.coId, wdprt], function(error2,jcost,fields2){
					cons.log(query2.sql)
					cons.log(error2)
					cons.log(jcost)
					cons.log(punch)
					res.jsonp({punch:punch, jcost:jcost})		
				})
			})
		}
	});
	router.get('/wstat/:wk', bearerTokenApp, function(req, res) {
		if(!req.userTok.auth){
			var mess={message: 'in get /tcard/wstat/:wk (not authorized)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{	
			const wk = req.params.wk
			const yr= moment().format('YYYY')
			const wprt = `${yr}-W${wk.toString().padStart(2,'0')}`
			var query = conn.query('SELECT `wprt`, `status`, `hrs` FROM tcardwk WHERE emailid = ? AND coid = ? AND wprt =?',[req.userTok.emailId, req.userTok.coId, wdprt], function(error,wstat,fields){
				cons.log(query.sql)
				cons.log(error)
				res.jsonp(wstat)
			})

		}
	})
	router.get('/week/:wk', bearerTokenApp, function(req, res) {
		if(!req.userTok.auth){
			var mess={message: 'in get /tcard/week/:wk (not authorized)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{	
			const wk = req.params.wk
			const yr= moment().format('YYYY')
			const wprt = `${yr}-W${wk.toString().padStart(2,'0')}`
			const wdprt =`${wprt}%`
			var query0 = conn.query('SELECT `wprt`, `status`, `hrs` FROM tcardwk WHERE emailid = ? AND coid = ? AND wprt =?',[req.userTok.emailId, req.userTok.coId, wprt], function(error0,wstat,fields){
				cons.log(query0.sql)
				cons.log(error0)
				cons.log(wstat)
				cons.log(wdprt)
				var query = conn.query('SELECT `wdprt`, `inout`, `hrs` FROM tcardpu WHERE emailid = ? AND coid = ? AND wdprt LIKE(?)',[req.userTok.emailId, req.userTok.coId, wdprt], function(error1,punch,fields){
					cons.log(query.sql)
					cons.log(error1)
					var query2 = conn.query('SELECT `wdprt`, `job`, `cat`, `hrs` FROM tcardjc WHERE emailid = ? AND coid = ? AND wdprt LIKE(?)',[req.userTok.emailId, req.userTok.coId, wdprt], function(error2,jcost,fields2){
						cons.log(query2.sql)
						cons.log(error2)
						cons.log(jcost)
						cons.log(punch)
						var q =conn.query('SELECT `job`, `category` FROM jobcatact WHERE week=? AND coid=? ORDER BY idx, category', [req.params.wk*1, req.userTok.coId ], function(error3, jobs, fields){
							cons.log(q.sql)
							cons.log(jobs)
							cons.log(error3)
							const wkarr = combinePuJc(punch,jcost,wk,req.userTok.emailId )
							res.jsonp({wk:wk, wkarr:wkarr, jobs:jobs, wstat:wstat[0]})
						})
					})
				})
			})
		}
	});
	router.delete('/del', bearerTokenApp, function(req,res){
		if(!req.userTok.auth){
			var mess={message: 'in get /tcard/delete (not authorized)-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			var mess={message: 'nothing happenning yet-'}
			const week = req.params.wk*1
			cons.log (req.body)
			const wdprt = req.body.wdprt
			var query1 = conn.query('DELETE FROM tcardpu WHERE wdprt=? AND emailid=? AND coid=?', [wdprt, req.userTok.emailId, req.userTok.coId], function(error,results,fields){
				cons.log(query1.sql)
				cons.log(error)
				cons.log(results)
				res.jsonp(results)
			})
		}	
	})	
	return router
}
const createBlWk =(wk, emailid)=>{
  let blwk=[]
  const wdprt = `${moment().format('YYYY')}-W${wk.toString().padStart(2,"0")}-`
  for (let i=1;i<=7;i++){
    let obj = {wdprt:wdprt+i, emailid:emailid, hrs:0, inout:[], jcost:[], jchrs:0}
    blwk.push(obj)
  }
  return blwk
}

const combinePuJc=(punch,jcost,wk,emailid)=>{
	const blwk = createBlWk(wk,emailid)
	const filledwk  = blwk.map((d)=>{
		punch
			.filter((pu)=>pu.wdprt==d.wdprt)
			.map((puf)=>{
				const pufioarr =  JSON.parse(puf.inout)
				d.hrs = resumHrs(pufioarr)
				d.inout = pufioarr
			})
		let jchrs=0
		let jcarr =[]	
		jcost	
			.filter((jc)=>jc.wdprt==d.wdprt)
			.map((jcf)=>{
				jchrs += jcf.hrs
				jcarr.push({job: jcf.job, cat:jcf.cat, hrs:jcf.hrs})
			})
		d.jcost = jcarr
		d.jchrs = jchrs			
		return d
	})
	return filledwk
}

const resumHrs = (inout)=>{
  let pin, pout, phrs, thrs=0
  inout.map((io,i)=>{
    if(i % 2 == 1){
      pout = io
      phrs = io2hrs(pin,pout)
      thrs += phrs*1
    }
    if(i % 2 == 0){
      pin = io
    }
  }) 
  return thrs  
}

const io2hrs = (pin, pout)=>{
  const ti = moment.duration(moment(pout, "HH:mm").diff(moment(pin, "HH:mm")));
  const hrs = (ti._data.hours + ti._data.minutes/60).toFixed(2);  
  return hrs
}