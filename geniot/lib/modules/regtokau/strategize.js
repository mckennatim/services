var mysql = require('mysql')
var BearerStrategy = require('passport-http-bearer').Strategy;
var jwt = require('jwt-simple');
var env = require('../../../env.json')
var cfg= env[process.env.NODE_ENV||'development']
var secret = cfg.secret;
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')

module.exports = function(passport) {
	passport.use(new BearerStrategy({},
		function(token, done) {
			process.nextTick(function() {
				cons.log('in bearer strategy')
				if (token) {
					try {
						var tokdata = jwt.decode(token, secret);
						cons.log(tokdata.email)
						conn.query('SELECT * FROM devuserapp  WHERE userid = ?', tokdata.email, function (error, results, fields) {
							if(!results){return done(null,false)}
							if(results.length>0){
								var resu =[]
								results.map((result)=>{
									resu.push(Object.assign({}, result))
								})
								return done(null, resu)								
							}else{
								return done(null,null)
							}
						})
					} catch (error) {
						cons.log(error)
						const err= 'token is no damn good'
						return done(err, null);
					}
				}				
			});
		}
	));
}

