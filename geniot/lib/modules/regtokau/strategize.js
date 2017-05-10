//var LocalStrategy = require('passport-localapikey').Strategy;
var BearerStrategy = require('passport-http-bearer').Strategy;
var jwt = require('jwt-simple');
var env = require('../../../env.json')
var cfg= env[process.env.NODE_ENV||'development']
//var cfg = require('../../cfg').cfg();
var secret = cfg.secret;
var cons = require('tracer').console();

// var User = require('../../db/user');
// // User.find().toArray(function(err, items) {
// // 	console.log(err);
// // 	console.log(items)
// // }

module.exports = function(passport) {
	passport.use(new BearerStrategy({},
		function(token, done) {
			process.nextTick(function() {
				cons.log('in bearer strategy')
				if (token) {
					var items ={secretstuff: 'dogfood'}
					return done(null, items)
					// try {
					// 	var user = jwt.decode(token, secret);
					// 	cons.log(user)
					// 	var name = user.name;
					// 	User.findOne({name: name}, function(err, items) {
					// 		cons.log(items)
					// 		if(!items){
					// 			return done(null,false)							
					// 		} else if (items.name === name) {
					// 			return done(null, items);
					// 		}
					// 		return done(null, null);
					// 	});
					// } catch (err) {
					// 	return done(err, null);
					// }
				}				
			});
		}
	));
}
// passport.use(new LocalStrategy(
	// 	function(apikey, done) {
	// 		// asynchronous verification, for effect...
	// 		process.nextTick(function() {
	// 			User.findOne({apikey: apikey}, function(err, items) {
	// 				if (items == null) {
	// 					return done(null, null);
	// 				} else if (items.apikey === apikey) {
	// 					return done(null, items);
	// 				}else if(!items){
	// 					return done(null, false, {
	// 						message: 'Unknown api ' + apikey
	// 					});	
	// 				}					
	// 				if (items.apikey != apikey) {
	// 					return done(null, false, {
	// 						message: 'wrong apikey'
	// 					});
	// 				}
	// 				return done(null, null);
	// 			});				
	// 		});
	// 	}
	// ));
// }
