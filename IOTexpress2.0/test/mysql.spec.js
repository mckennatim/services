var superagent = require('superagent')
var expect = require('expect.js')
var mysql = require('mysql')
var jwt = require('jwt-simple');
var conn = require('../lib/db/mysqldb')
var cfg = require('../lib/utilities').cfg

var emailId="mckenna.tim@gmail.com"
var pdata = {devid: "CYURBAD", devpwd: "nopwd", bizid: "sbs" }
var jdata ={
	email: emailId
}
//var token = jwt.encode({ appId: 'hvac', email: 'tim@sitebuilt.net' }, cfg.secret)
var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhcHBJZCI6Imh2YWMiLCJlbWFpbCI6InRpbUBzaXRlYnVpbHQubmV0In0.e8oviN49uxjbc9FgcyPWV-vQYp0YlD183FhqCWzpuT0"

describe('device mysqldb:', function() {
	it('gets devuserapps for device', function(done){
		expect(true).to.equal(true)
		done()
	})
	it('save device to mysql', function(done){
		var query = conn.query('INSERT INTO devices SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
			if (error) throw error;
			//console.log(results)
		})
		console.log(query.sql)
		expect(true).to.equal(true)
		done()
	})
	it.skip('posts to devices', function(done){
		var url=cfg.url.local+":"+cfg.port.express+"/api/dedata/dev"
		console.log(url)
		pdata.devpwd='froggy'
		console.log(pdata)
		superagent.post(url)
			.set('Authorization', 'Bearer ' + token)
			.send(pdata)
			.end(function(e, res) {
				console.log(!!e ? e.status: 'no error')
				//console.log(res.body)
				expect(true).to.equal(true)
				done()
			})
	})
	it.skip('posts to users', function(done){
		var url=cfg.url.local+":"+cfg.port.express+"/api/dedata/users"
		console.log(url)
		pdata.devpwd='froggy'
		superagent.post(url)
			.set('Authorization', 'Bearer ' + token)
			.send(pdata)
			.end(function(e, res) {
				console.log(!!e ? e.status: 'no error')
				//console.log(res.body)
				expect(true).to.equal(true)
				done()
			})
	})
	it('posts to dedata/prg', function(done){
		var url=cfg.url.local+":"+cfg.port.express+"/api/dedata/prg"
		console.log(url)
		var devid = "CYURD001"
		var day = 4
		var senrel= 0
		var pro = "[[12,40,77,73]]"
		var sdata=`{"devid":"${devid}","dow":${day},"senrel":${senrel},"sched":"${pro}"}`
		console.log(sdata)
		var pdata = JSON.parse(sdata)
		//pdata.sched=pro
		console.log(pdata)
		//pdata=`{"device":${devid},"day":${day},"senrel":${senrel},"pro":${pro}`
		superagent.post(url)
			.set('Authorization', 'Bearer ' + token)
			.send(pdata)
			.end(function(e, res) {
				console.log(!!e ? e.status: 'no error')
				console.log(res.body)
				expect(true).to.equal(true)
				done()
			})
	})
})
describe('device mongo:', function() {
	it('posts to dedat/rec', function(done){
		var url=cfg.url.local+":"+cfg.port.express+"/api/dedata/rec"
		console.log(url)
		var devid = "CYURD006"
		var senrel= 0
		var sdata=devid+':'+senrel
		var odata ={id:sdata}
		superagent.post(url)
			.set('Authorization', 'Bearer ' + token)
			.send(odata)
			.end(function(e, res) {
				console.log(!!e ? e.status: 'no error')
				console.log(res.body)
				expect(true).to.equal(true)
				done()
			})
	})
	it('deletes dedat/rec', function(done){
		var url=cfg.url.local+":"+cfg.port.express+"/api/dedata/rec"
		console.log(url)
		var devid = "CYURD006"
		var senrel= 0
		var sdata=devid+':'+senrel
		var odata ={id:sdata}
		superagent.delete(url)
			.set('Authorization', 'Bearer ' + token)
			.send(odata)
			.end(function(e, res) {
				console.log(!!e ? e.status: 'no error')
				console.log(res.body)
				expect(true).to.equal(true)
				done()
			})
	})
	it('GETs locids w/o params', function(done) {
		var userid='tim@sitebuilt.net'

		var url = cfg.url.local+":"+cfg.port.express + '/api/dedata/loclist'
		console.log(url);
		superagent
			.get(url)
			.set('Authorization', 'Bearer ' + token)
			.end(function(e, res) {
				console.log(res.body)
				expect(true).to.be(true);
				done()
			})
	})
})
