var express = require('express');
var cons = require('tracer').console();

var router = express.Router();

module.exports = function(passport) {
	router.get('/', function(req, res) {
		res.jsonp({message: "in root of dedata module"})		
	});

	router.get('/apps', 
		passport.authenticate('bearer', { session: false }), 
		function(req,res){
			cons.log('in router after auth')
			cons.log(req.user)
			res.jsonp({message: "unprotected trial"})		
	})
	return router
}