var FacebookStrategy = require('passport-facebook').Strategy;
var TwitterStrategy  = require('passport-twitter').Strategy;
var GithubStrategy  = require('passport-github').Strategy;
var GoogleStrategy   = require('passport-google-oauth').OAuth2Strategy;
var cons = require('tracer').console();
var User       = require('../app/models').moUser;
var env = require('../env.json')
var cfg= env[process.env.NODE_ENV||'development']
var configAuth = cfg.auth; 
var mf = require('./funcs')

module.exports = function(passport) {

    // =========================================================================
    // passport session setup ==================================================
    // =========================================================================
    // required for persistent login sessions
    // passport needs ability to serialize and unserialize users out of session

    // used to serialize the user for the session
    passport.serializeUser(function(user, done) {
        done(null, user.id);
    });

    // used to deserialize the user
    passport.deserializeUser(function(id, done) {
        User.findById(id, function(err, user) {
            done(err, user);
        });
    });

	// =========================================================================
	// FACEBOOK new data model================================================================
	// =========================================================================
	var fbStrategy = configAuth.facebookAuth;
	fbStrategy.passReqToCallback = true;  // allows us to pass in the req from our route (lets us check if a user is logged in or not)
	passport.use(new FacebookStrategy(fbStrategy,
			function(req, token, refreshToken, profile, done) {
			cons.log(req);
			//cons.log(profile);
			//cons.log(done);
			//cons.log(req._toParam)
			if (!mf.get('profile.emails', profile)){
				cons.log('no email in this twitter account')
				// return done('authentication is based on email, try a social media app that has your email or use local signup option',null)
				mf.setMessage('Authentication is based on email, back arrow and try a social media app that has your email or use local signup option.')
				return done(null,null)
			}			
			var email = (profile.emails[0].value || '').toLowerCase()
			process.nextTick(function() {
				var appid = mf.getCurrApp();
				cons.log(appid)
				// check if the user is already logged in
				if (!req.user || !req.user.facebook) {
					User.findOne({ 'userinfo.emailkey' : email }, function(err, user) {
						if (err) return done(err);
						if (user) {
							if (!user.facebook) { //add a new facebook user
								user.facebook.id = profile.id
								user.facebook.token = token;
								user.facebook.name  = profile.name.givenName + ' ' + profile.name.familyName;
								user.save(function(err) {
									if (err) return done(err);
									return done(null, user);
								});
							} else if (!user.facebook.token ) { 
								user.facebook.token = token;
								user.save(function(err) {
									if (err) return done(err);
									return done(null, user);
								});
							}
							return done(null, user); // user found, return that user
						} else {
							// if there is no user, create them
							var newUser            = new User();
							newUser.facebook.id    = profile.id;
							newUser.facebook.token = token;
							newUser.facebook.name  = profile.name.givenName + ' ' + profile.name.familyName;
							newUser.userinfo.emailkey = email;
							newUser.save(function(err) {
								if (err) return done(err);
								return done(null, newUser);
							});
						}
					});
				} else {
					// user already exists and is logged in, we have to link accounts
					var user            = req.user; // pull the user out of the session
					user.facebook.id    = profile.id;
					user.facebook.token = token;
					user.facebook.name  = profile.name.givenName + ' ' + profile.name.familyName;
					user.userinfo.emailkey = (profile.emails[0].value || '').toLowerCase();
					user.save(function(err) {
						if (err) return done(err);
						return done(null, user);
					});
				}
			});
	}));	
	// =========================================================================
	// GITHUB new data model================================================================
	// =========================================================================
	var ghStrategy = configAuth.githubAuth;
	ghStrategy.passReqToCallback = true;  // allows us to pass in the req from our route (lets us check if a user is logged in or not)
	passport.use(new GithubStrategy(ghStrategy,
		function(req, token, refreshToken, profile, done) {
			var email = (profile.emails[0].value || '').toLowerCase()
			console.log(email)
			process.nextTick(function() {
				cons.log(req.user)
				// check if the user is already logged in
				if (!req.user || !req.user.github) {
					User.findOne({ 'userinfo.emailkey' : email }, function(err, user) {
						console.log(user)
						console.log(err)
						if (err) return done(err);
						if (user) {
							cons.log(user)
							if (!user.github) { //add a new github user
								user.github.id = profile.id
								user.github.token = token;
								user.github.name  = profile.displayName;
								user.save(function(err) {
									if (err) return done(err);
									return done(null, user);
								});
							} else if (!user.github.token ) { 
								user.github.token = token;
								user.save(function(err) {
									if (err) return done(err);
									return done(null, user);
								});
							}
							return done(null, user); // user found, return that user
						} else {
							// if there is no user, create them
							var newUser            = new User();
							newUser.github.id    = profile.id;
							newUser.github.token = token;
							newUser.github.name  = profile.displayName;
							newUser.userinfo.emailkey = email;
							newUser.save(function(err) {
								if (err) return done(err);
								return done(null, newUser);
							});
						}
					});
				} else {
					// user already exists and is logged in, we have to link accounts
					var user            = req.user; // pull the user out of the session
					user.github.id    = profile.id;
					user.github.token = token;
					user.github.name  = profile.displayName;
					user.userinfo.emailkey = (profile.emails[0].value || '').toLowerCase();
					user.save(function(err) {
						if (err) return done(err);
						return done(null, user);
					});
				}
			});
	}));
	// =========================================================================
	// TWITTER new data model================================================================
	// =========================================================================
	var twStrategy = configAuth.twitterAuth;
	twStrategy.passReqToCallback = true;  // allows us to pass in the req from our route (lets us check if a user is logged in or not)
	passport.use(new TwitterStrategy(twStrategy,
		function(req, token, refreshToken, profile, done) {
			//cons.log(profile)//frog
			if (!mf.get('profile.emails', profile)){
				cons.log('no email in this twitter account')
				// return done('authentication is based on email, try a social media app that has your email or use local signup option',null)
				mf.setMessage('Authentication is based on email, back arrow and try a social media app that has your email or use local signup option.')
				return done(null,null)
			}
			var email = (profile.emails[0].value || '').toLowerCase()
			cons.log(email)
			process.nextTick(function() {
				cons.log(req.user)
				// check if the user is already logged in
				if (!req.user || !req.user.twitter) {
					User.findOne({ 'userinfo.emailkey' : email }, function(err, user) {
						cons.log(user)
						cons.log(err)
						if (err) return done(err);
						if (user) {
							cons.log(user)
							if (!user.twitter) { //add a new twitter user
								user.twitter.id = profile.id
								user.twitter.token = token;
								user.twitter.displayName  = profile.displayName;
								user.twitter.username  = profile.username;
								user.save(function(err) {
									if (err) return done(err);
									return done(null, user);
								});
							} else if (!user.twitter.token ) { 
								user.twitter.token = token;
								user.save(function(err) {
									if (err) return done(err);
									return done(null, user);
								});
							}
							return done(null, user); // user found, return that user
						} else {
							// if there is no user, create them
							var newUser            = new User();
							newUser.twitter.id    = profile.id;
							newUser.twitter.token = token;
							newUser.twitter.displayName  = profile.displayName;
							newUser.twitter.username  = profile.username;
							newUser.userinfo.emailkey = email;
							newUser.save(function(err) {
								if (err) return done(err);
								return done(null, newUser);
							});
						}
					});
				} else {
					// user already exists and is logged in, we have to link accounts
					var user            = req.user; // pull the user out of the session
					user.twitter.id    = profile.id;
					user.twitter.token = token;
					user.twitter.displayName  = profile.displayName;
					user.twitter.username  = profile.username;
					user.userinfo.emailkey = (profile.emails[0].value || '').toLowerCase();
					user.save(function(err) {
						if (err) return done(err);
						return done(null, user);
					});
				}
			});
	}));
	// =========================================================================
	// GOOGLE new data model================================================================
	// =========================================================================
	var goStrategy = configAuth.googleAuth;
	goStrategy.passReqToCallback = true;  // allows us to pass in the req from our route (lets us check if a user is logged in or not)
	passport.use(new GoogleStrategy(goStrategy,
		function(req, token, refreshToken, profile, done) {
			var email = (profile.emails[0].value || '').toLowerCase()
			console.log(email)
			process.nextTick(function() {
				cons.log(req.user)
				// check if the user is already logged in
				if (!req.user || !req.user.google) {
					User.findOne({ 'userinfo.emailkey' : email }, function(err, user) {
						console.log(user)
						console.log(err)
						if (err) return done(err);
						if (user) {
							cons.log(user)
							if (!user.google) { //add a new google user
								user.google.id = profile.id
								user.google.token = token;
								user.google.displayName  = profile.displayName;
								user.save(function(err) {
									if (err) return done(err);
									return done(null, user);
								});
							} else if (!user.google.token ) { 
								user.google.token = token;
								user.save(function(err) {
									if (err) return done(err);
									return done(null, user);
								});
							}
							return done(null, user); // user found, return that user
						} else {
							// if there is no user, create them
							var newUser            = new User();
							newUser.google.id    = profile.id;
							newUser.google.token = token;
							newUser.google.displayName  = profile.displayName;
							newUser.userinfo.emailkey = email;
							newUser.save(function(err) {
								if (err) return done(err);
								return done(null, newUser);
							});
						}
					});
				} else {
					// user already exists and is logged in, we have to link accounts
					var user            = req.user; // pull the user out of the session
					user.google.id    = profile.id;
					user.google.token = token;
					user.google.displayName  = profile.displayName;
					user.userinfo.emailkey = (profile.emails[0].value || '').toLowerCase();
					user.save(function(err) {
						if (err) return done(err);
						return done(null, user);
					});
				}
			});
	}));
};
