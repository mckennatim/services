var superagent = require('superagent')
var expect = require('expect.js')
var should = require('should')
var _ = require('underscore')
var jwt = require('jwt-simple');
var fs = require('fs');
var env = require('../env.json')
var cfg= env[process.env.NODE_ENV||'development']
var secret = cfg.secret
 
var httpLoc = cfg.url.local +':'+ cfg.port.express + '/api/'
//expires in an hour
var payload = {
	appId: "jobs",
	email: "tim@sitebuilt.net",
	exp: Math.floor(Date.now() / 1000) + (60 * 60) 
};
var token = jwt.encode(payload, secret);

describe('regtokau:', function() {
	var agent = superagent.agent();
	var name = 'tim7';
	var ucnt = 0;
	var apikey = 'dog';
	var ureg = 'tim2';
	var uav = 'fred';
	var eregtim = 'tim2@sitebuilt.net';
	var enottim = 'mckenna.nottim@gmail.com';
	it('GET / should be running and return: please select...', function(done) {
		superagent.get(httpLoc+'reg')
			.end(function(e, res) {
				console.log(res.body.message)
				expect(e).to.eql(null)
				expect(res.body).to.be.a('object')
				expect(res.body.message).to.eql('in root of registration module')
				done()
			})
	})
})
describe('jobs:', function(){
	it('GETs jobs from api/jobs/list when passed token', function(done) {
		var url = httpLoc + 'jobs/list/0'
		superagent
			.get(url)
			.set('Authorization', 'Bearer ' + token)
			.end(function(e, res) {
				console.log(res.body)
				expect(res.body).to.be.an('object');
				done()
			})
	})	
})


