var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerTokenApp = require('../regtokau/strategy').bearerTokenApp
var cfg = require('../../utilities').cfg
var Reco = require('../../db/models').Reco

var router = express.Router();

module.exports = function() {
	router.get('/', function(req, res) {
		res.jsonp({message: "in root of tom module"})
	});
	router.get('/amts', function(req,res){
		console.log('in /tom/amts no params')
		var q =conn.query('SELECT amt FROM heirlooms',  function(error, results, fields){
			console.log(q.sql)
			var arrres = results.map((dev)=>dev.amt)
			res.jsonp(arrres)
		})
	})
	router.post('/pst', function(req,res){
			var pdata=req.body
			console.log(pdata)
			let csel = JSON.parse(pdata.selected)
		  let ids= []
		  let pids =[]
		  let resu
			csel.map((d,i)=>{
		    if (d==1){
		      ids.push(i+1)
		    }
		  })
		  cons.log(ids)
		  var query2 = conn.query('SELECT selected FROM hepeop WHERE name= ?', pdata.name, function(error,results,fields){
				cons.log(query2.sql)
				var arrres = results.map((dev)=>dev.selected)
				var query = conn.query('INSERT INTO hepeop SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
						console.log(query.sql)
						if (error) {
							throw error;
							console.log({message: error})
						}else{
							console.log(results)
						}
			  		var query4 = conn.query('UPDATE heirlooms SET amt = amt - 1 WHERE id IN ( ? )', [ids], function(error,results,fields){
			  			cons.log(query4.sql)
							if (arrres[0]){
								let prarr = JSON.parse(arrres[0])
					  		prarr.map((p,i)=>{
					  			if(p==1){
					  				pids.push(i+1)
					  			}
					  		})
					  		cons.log(pids)
					  		var query3 = conn.query('UPDATE heirlooms SET amt = amt +1 WHERE id IN ( ? )', [pids], function(error,results,fields){
					  			cons.log(query3.sql)
					  			res.jsonp({message:'hello'})
					  		})
							}else{
								res.jsonp({message:'hello'})
							}				  			
			  		})						
				})		  
				
			})

			
	})
	return router
}


