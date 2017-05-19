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
		cons.log(req.tokenAuth)
		res.jsonp(req.tokenAuth)
	})
	return router
}