var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerToken = require('../regtokau/strategy').bearerToken

var router = express.Router();

module.exports = function() {
	router.get('/', function(req, res) {
		res.jsonp({message: "in root of dedata module"})		
	});
	router.get('/apps', bearerToken, function(req,res){
		//cons.log(req.userTok)
		//get descriptions of apps and add them in
		res.jsonp(req.userTok)
	})
	router.post('/dev', bearerToken, function(req,res){
		cons.log('in post dev')
		//cons.log(req.userTok)
		if(!req.userTok.auth){
			//console.log(req.userTok.message)
			var mess={message: 'not authoried-'+req.userTok.message}
			cons.log(mess)
			res.jsonp(mess)
		}else{
			var pdata=req.body
			// save a new device
			var query = conn.query('INSERT INTO devices SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
				if (error) {
					throw error;
					res.jsonp({message: error})
				}else{
					console.log(results)
					res.jsonp({message: results})
				}
			})
		}
	})
	return router
}