
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
			var query = conn.query('INSERT INTO tcardpu SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
				cons.log(query.sql)
				cons.log(error)
				cons.log(results)
				let jcdata = {wdprt: wdprt, emailid: req.userTok.emailId, coid: 		req.userTok.coId}
				jcost.map((jc)=>{
					jcdata.job=jc.job
					jcdata.cat=jc.cat
					jcdata.hrs=jc.hrs
					var query2 = conn.query('INSERT INTO tcardjc SET ? ON DUPLICATE KEY UPDATE ?', [jcdata,jcdata], function(error,results,fields){
						cons.log(query2.sql)
						cons.log(error)
						cons.log(results)
					})
				})
				res.jsonp(req.body)
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
	router.get('/week/:wk', bearerTokenApp, function(req, res) {
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
					const wkarr = combinePuJc(punch,jcost)
					res.jsonp({wk:wk, wkarr:wkarr})		
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
				res.jsonp(mess)
			})
		}	
	})	
	return router
}

const combinePuJc=(punch,jcost)=>{
	if(punch.lenght==0){
		return[]
	}else{
		let narr= punch.map((p)=>{
			nob={wdprt:p.wdprt, hrs:p.hrs, inout:p.inout}
			let jchrs = 0
			if(jcost.length==0){
				nob.jcost=[]
				nob.jchrs=0
				return nob
			}else{
				let jcarr = jcost
				.filter((j)=>j.wdprt==p.wdprt)
				.map((jd)=>{
					jchrs+=jd.hrs
					return {job:jd.job, cat:jd.cat, hrs:jd.hrs}
				})
			nob.jcost=jcarr	
			nob.jchrs=jchrs
			return nob
			}
		})
		cons.log('narr: ', narr)
		return narr
	}

}
