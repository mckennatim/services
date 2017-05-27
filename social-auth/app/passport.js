// load all the things we need
var LocalStrategy    = require('passport-local').Strategy;
var ApikeyStrategy = require('passport-localapikey').Strategy;
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
    // LOCAL APIKEY LOGIN =============================================================
    // =========================================================================    
		// passport.use(new ApikeyStrategy(
		// 	function(apikey, done) {
		// 		process.nextTick(function() {
		// 			User.findOne({'local.apikey': apikey}, function(err, items) {
		// 				cons.log(items)
		// 				if (items == null) {
		// 					return done(null, null);
		// 				} else if (items.local.apikey === apikey) {
		// 					cons.log('write auth = true')
		// 					var updUser = items
		// 					updUser.local.auth = true
		// 					updUser.save(function(err) {
  //         			if (err) done(err, null, {message: 'upd error'});          			
		// 						return done(null, updUser, {message: 'should be good'} );
		// 					})
		// 				}else if(!items){
		// 					return done(null, false, {
		// 						message: 'Unknown api ' + apikey
		// 					});	
		// 				}					
		// 				if (items.local.apikey != apikey) {
		// 					return done(null, false, {
		// 						message: 'wrong apikey'
		// 					});
		// 				}
		// 				return done(null, null);
		// 			});				
		// 		});
		// 	}
		// ));
    // =========================================================================
    // LOCAL LOGIN =============================================================
    // =========================================================================
    passport.use('local-login', new LocalStrategy({
        // by default, local strategy uses username and password, we will override with email
        usernameField : 'email',
        passwordField : 'password',
        passReqToCallback : true // allows us to pass in the req from our route (lets us check if a user is logged in or not)
    },
    function(req, email, password, done) {
        if (email)
            email = email.toLowerCase(); // Use lower-case e-mails to avoid case-sensitive e-mail matching
        // asynchronous
        process.nextTick(function() {
            User.findOne({ 'local.email' :  email }, function(err, user) {
                // if there are any errors, return the error
                if (err)
                    return done(err);
                // if no user is found, return the message
                if (!user)
                    return done(null, false, req.flash('loginMessage', 'No user found.'));
                if (!user.validPassword(password))
                    return done(null, false, req.flash('loginMessage', 'Oops! Wrong password.'));
                // all is well, return user
                else
                    return done(null, user);
            });
        });

    }));

    // =========================================================================
    // LOCAL SIGNUP ============================================================
    // =========================================================================
    passport.use('local-signup', new LocalStrategy({
        // by default, local strategy uses username and password, we will override with email
        usernameField : 'email',
        passReqToCallback : true // allows us to pass in the req from our route (lets us check if a user is logged in or not)
    },
    function(req, email, done) {
    		cons.log(email)
    		cons.log('somewhere')
        if (email)
            email = email.toLowerCase(); // Use lower-case e-mails to avoid case-sensitive e-mail matching
        // asynchronous
        process.nextTick(function() {
        		cons.log("in local-signup")
        		cons.log(email)
            // if the user is not already logged in:
            // if (!req.user) {
            //     User.findOne({ 'local.email' :  email }, function(err, user) {
            //         if (err)
            //             return done(err);
            //         if (user) {
            //             return done(null, false, req.flash('signupMessage', 'That email is already taken.'));
            //         } else {
            //             var newUser            = new User();
            //             newUser.local.email    = email;
            //             newUser.local.password = newUser.generateHash(password);
            //             newUser.save(function(err) {
            //                 if (err)
            //                     return done(err);
            //                 return done(null, newUser);
            //             });
            //         }
            //     });
            // // if the user is logged in but has no local account...
            // } else if ( !req.user.local.email ) {
            //     // ...presumably they're trying to connect a local account
            //     // BUT let's check if the email used to connect a local account is being used by another user
            //     User.findOne({ 'local.email' :  email }, function(err, user) {
            //         if (err)
            //             return done(err);
            //         if (user) {
            //             return done(null, false, req.flash('loginMessage', 'That email is already taken.'));
            //             // Using 'loginMessage instead of signupMessage because it's used by /connect/local'
            //         } else {
            //             var user = req.user;
            //             user.local.email = email;
            //             user.local.password = user.generateHash(password);
            //             user.save(function (err) {
            //                 if (err)
            //                     return done(err);
            //                 return done(null,user);
            //             });
            //         }
            //     });
            // } else {
            //     // user is logged in and already has a local account. Ignore signup. (You should log out before trying to create a new account, user!)
            //     return done(null, req.user);
            // }
        });
    }));

	// =========================================================================
	// FACEBOOK new data model================================================================
	// =========================================================================
	var fbStrategy = configAuth.facebookAuth;
	fbStrategy.passReqToCallback = true;  // allows us to pass in the req from our route (lets us check if a user is logged in or not)
	passport.use(new FacebookStrategy(fbStrategy,
			function(req, token, refreshToken, profile, done) {
			//cons.log(req);
			//cons.log(profile);
			//cons.log(done);
			//cons.log(req._toParam)
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
			var email = (profile.emails[0].value || '').toLowerCase()
			console.log(email)
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
