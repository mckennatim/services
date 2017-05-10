var express = require('express');
var mongoose = require('mongoose');
var mysql      = require('mysql');
var jwt = require('jwt-simple');
var cons = require('tracer').console();
var env = require('../../../env.json')
var mo =require('../../db/models')

var cfg= env[process.env.NODE_ENV||'development']
var db = cfg.db
var secret = cfg.secret

var router = express.Router();

var conn = mysql.createConnection(cfg.mysql);
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
		const payload = jwt.decode(req.body.token, secret)
		cons.log(payload)
		if (payload.email==cfg.super){
			//if you are a superuser add if no there the superuser records
			const superdev = "CYURD14I"
			cons.log('your are a superuser')
			var ins = {devid: superdev, userid: payload.email, appid: 'superapp', role:'super', auth: true }
			var ins2 = {devid: superdev, userid: payload.email, appid: 'admin', role:'admin', auth: true }
			var ins3 = {devid: superdev, userid: payload.email, appid: payload.appId, role:'admin', auth: true }
			conn.query('INSERT INTO devuserapp SET ?', ins , function (error, results, fields) {
			  if(error) {
			  	console.log(error.code)
			  }else {
			  	console.log(results.insertId);
			  }
			})
			conn.query('INSERT INTO devuserapp SET ?', ins2 , function (error, results, fields) {
			  if(error) {
			  	console.log(error.code)
			  }else {
			  	console.log(results.insertId);
			  }
			})
			conn.query('INSERT INTO devuserapp SET ?', ins3 , function (error, results, fields) {
			  if(error) {
			  	console.log(error.code)
			  }else {
			  	console.log(results.insertId);
			  }
			})
			res.jsonp({message: 'authenticated a superuser'});
		}else{
			//see if there are any apps/devices for that user or tell them they are shit outa luck and should contact the bossman to add your email to the system, meeanwhile you can put them in with no apps or devices or auth
			conn.query('SELECT * FROM devuserapp  WHERE userid = ?', payload.email, function (error, results, fields) {
				// // cons.log(Object.assign({}, results[0]))
				// var resu =[]
				// results.map((result)=>{
				// 	resu.push(Object.assign({}, result))
				// })
				// cons.log(resu.length)
				if(results.length==0){
					conn.query('INSERT INTO devuserapp SET ? ', {userid: payload.email, auth:false} , function (error, results, fields){
							res.jsonp({message: 'added a new user'});
						})
				}else{
					res.jsonp({message: 'user exists'});
				}

			})
		}
	})
	return router;
}

	// router.get('/postauth/:email/:appid', function(req,res){
	// 	cons.log(req.params)
	// 	//create token from email 
	// 	res.jsonp({message: 'back from postauth'});
	// })

	// router.post('/authenticate/:name', 
	// //passport.authenticate('localapikey', {session: false, failureRedirect: '/unauthorized'}),
	// 	passport.authenticate('localapikey', {session: false}),
	// 	function(req, res) {
	// 		console.log(req.params)
	// 		cons.log(req.user)
	// 		console.log('just sent body in /authenticate')
	// 		if (req.params.name==req.user.name){
	// 			cons.log('names match')
	// 			var payload = {name: req.user.name};
	// 			var token = jwt.encode(payload, secret);
	// 			var name =jwt.decode(token, secret);
	// 			cons.log(name)
	// 			res.jsonp({message: 'token here', token: token});
	// 			cons.log(token);     
	// 		}else {
	// 			res.jsonp({message: 'apikey does not match user'});
	// 		}
	// 	}
	// );
	// router.get('/account', 
	// 	passport.authenticate('bearer', { session: false }), 
	// 	function(req, res){ 
	// 		console.log('in api/account ') 
	// 		console.log(req.body)
	// 		res.jsonp(req.user)
	// 	}
	// );
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

// 	return router;
// }

        // "_id" : ObjectId("56f4156d518e55f815a3abc9"),
        // "devid" : "CYURD001",
        // "domain" : "parley",
        // "loc" : {
        //         "lat" : 14.345,
        //         "lng" : -72.444,
        //         "timezone" : "America/New_York",
        //         "address" : "12 Parley Vale, Jamaica Plain, MA 02130"
        // },
        // "users" : [
        //         {
        //                 "name" : "tim",
        //                 "email" : "mckenna.tim@gmail.com"
        //         }
        // ],
        // "usersarr" : [
        //         "tim"
        // ],
        // "__v" : 0