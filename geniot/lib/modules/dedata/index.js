var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerToken = require('../regtokau/strategy').bearerToken

var router = express.Router();

module.exports = function(passport) {
	router.get('/', function(req, res) {
		res.jsonp({message: "in root of dedata module"})		
	});

	router.get('/apps', 
		passport.authenticate('bearer', { session: false }), 
		function(req,res){
			cons.log('in router after auth')
			console.log(res)
			if (res.status==500){
				res.jsonp({message: 'no user registered with that token'})
			}else{
				res.jsonp({apps: req.user})
			}		
	})

	// router.get('/appsa', function(req,res){
	// 	bearerToken(req,res, function(){
	// 		cons.log(req.tokenAuth)
	// 		res.jsonp(req.tokenAuth)
	// 	})
	// })
	router.get('/appsa', bearerToken, function(req,res){
		// bearerToken(req,res, function(){
			cons.log(req.tokenAuth)
			res.jsonp(req.tokenAuth)
		// })
	})
	return router
}