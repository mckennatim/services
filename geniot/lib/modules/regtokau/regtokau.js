var express = require('express');
var mongoose = require('mongoose');
var jwt = require('jwt-simple');
var cons = require('tracer').console();
var env = require('../../../env.json')
var mo =require('../../db/models')

var cfg= env[process.env.NODE_ENV||'development']
var db = cfg.db
var secret = cfg.secret
var authSecret = cfg.auth[0].secret

var router = express.Router();

mongoose.connect(db.url);
//var User = require('../../db/user');
var emailKey = require('./util').emmailKey
var createRandomWord = require('./util').createRandomWord
var blankUser= {name: '', email: '', lists:[], role:'', timestamp: 1, apikey: ''};

module.exports = function(passport) {
	router.get('/', function(req, res) {
		res.jsonp({message: "in root of registration module"})		
	});

	router.post('/auth', function(req, res){
		const payload = jwt.decode(req.body.token, authSecret)
		cons.log(payload)
		if (payload.email==cfg.super){
			cons.log('your are a superuser')
			var moload = {
				email: payload.email,
				$addToSet: {devices: "CYURD14I"}
			}
			mo.Uuser.update({email: payload.email}, moload, {upsert: true}, function(err,result){})
		}
		res.jsonp({message: 'back from auth'});
	})

	router.get('/postauth/:email', function(req,res){
		cons.log(req.params)
		//res.jsonp({message: 'back from postauth'});
		res.jsonp(['message:','back from postauth']);
	})

	router.post('/authenticate/:name', 
	//passport.authenticate('localapikey', {session: false, failureRedirect: '/unauthorized'}),
		passport.authenticate('localapikey', {session: false}),
		function(req, res) {
			console.log(req.params)
			cons.log(req.user)
			console.log('just sent body in /authenticate')
			if (req.params.name==req.user.name){
				cons.log('names match')
				var payload = {name: req.user.name};
				var token = jwt.encode(payload, secret);
				var name =jwt.decode(token, secret);
				cons.log(name)
				res.jsonp({message: 'token here', token: token});
				cons.log(token);     
			}else {
				res.jsonp({message: 'apikey does not match user'});
			}
		}
	);
	router.get('/account', 
		passport.authenticate('bearer', { session: false }), 
		function(req, res){ 
			console.log('in api/account ') 
			console.log(req.body)
			res.jsonp(req.user)
		}
	);
	// router.get('/isUser/:name', function(req, res) {
	// 	console.log('in isUser by name');
	// 	var name = req.params.name.toLowerCase();
	// 	console.log(name)
	// 	User.findOne({name: name}, function(err, items) {
	// 		console.log(items)
	// 		if (items != null && items.name == name) {
	// 			console.log('is registered')
	// 			res.jsonp({
	// 				message: ' already registered'
	// 			})
	// 		} else {
	// 			res.jsonp({
	// 				message: ' available'
	// 			});
	// 		}
	// 	});
	// });
	// router.delete('/users/:name',
	// 	passport.authenticate('bearer', { session: false }),  
	// 	function(req, res) {
	// 		console.log('in delete user by name');
	// 		console.log(req.params);
	// 		var name = req.params.name;
	// 		User.remove({name: name}, function(err, resp) {
	// 			//console.log(resp)
	// 			res.jsonp({message: resp})
	// 		});
	// 	}
	// );	

	return router;
}
