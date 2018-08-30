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
	appId: "reroo-jobs",
	email: "noah@sitebuilt.net",
	exp: Math.floor(Date.now() / 1000) + (60 * 60) 
};
var token = jwt.encode(payload, secret);

var payload2 = {
	appId: "reroo-jobs",
	email: "tim@sitebuilt.net",
	exp: Math.floor(Date.now() / 1000) + (60 * 60) 
};
var token2 = jwt.encode(payload2, secret);

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
	const aj = { jobs:
   [ { id: 1,
       job: 'Marketting',
       category: null,
       active: 0,
       week: 0,
       idx: 1,
       coid: 'reroo' },
     { id: 2,
       job: 'Nursery',
       category: null,
       active: 1,
       week: 0,
       idx: 2,
       coid: 'reroo' },
     { id: 3,
       job: 'Truck and tools',
       category: null,
       active: 0,
       week: 0,
       idx: 3,
       coid: 'reroo' },
     { id: 59,
       job: 'HYCC',
       category: null,
       active: 0,
       week: 0,
       idx: 4,
       coid: 'reroo' },
     { id: 60,
       job: 'HYCC',
       category: 'constr',
       active: 0,
       week: 0,
       idx: 4,
       coid: 'reroo' },
     { id: 58,
       job: 'HYCC',
       category: 'maintain',
       active: 0,
       week: 0,
       idx: 4,
       coid: 'reroo' },
     { id: 4,
       job: 'HYCC',
       category: 'plant',
       active: 0,
       week: 0,
       idx: 4,
       coid: 'reroo' },
     { id: 5,
       job: 'Ken Wing - Rockview',
       category: null,
       active: 0,
       week: 0,
       idx: 5,
       coid: 'reroo' },
     { id: 61,
       job: 'Ken Wing - Rockview',
       category: 'constr',
       active: 0,
       week: 0,
       idx: 5,
       coid: 'reroo' },
     { id: 6,
       job: 'Eastie Farm',
       category: null,
       active: 0,
       week: 0,
       idx: 6,
       coid: 'reroo' },
     { id: 7,
       job: '15 Atherton',
       category: null,
       active: 0,
       week: 0,
       idx: 7,
       coid: 'reroo' },
     { id: 8,
       job: '2054 Dot Ave',
       category: null,
       active: 1,
       week: 0,
       idx: 8,
       coid: 'reroo' },
     { id: 9,
       job: '105 Green St',
       category: null,
       active: 0,
       week: 0,
       idx: 9,
       coid: 'reroo' },
     { id: 10,
       job: 'Egelston Library',
       category: null,
       active: 1,
       week: 0,
       idx: 10,
       coid: 'reroo' },
     { id: 11,
       job: '19 cornelius way',
       category: null,
       active: 0,
       week: 0,
       idx: 11,
       coid: 'reroo' },
     { id: 12,
       job: '20 Alveston',
       category: null,
       active: 0,
       week: 0,
       idx: 12,
       coid: 'reroo' },
     { id: 13,
       job: '16 roanoke',
       category: null,
       active: 1,
       week: 0,
       idx: 13,
       coid: 'reroo' },
     { id: 14,
       job: 'Roz Walter - 20 Dell',
       category: null,
       active: 0,
       week: 0,
       idx: 14,
       coid: 'reroo' },
     { id: 15,
       job: 'Boston Microgreens',
       category: null,
       active: 1,
       week: 0,
       idx: 15,
       coid: 'reroo' },
     { id: 16,
       job: 'Gibran and Samantha',
       category: null,
       active: 1,
       week: 0,
       idx: 16,
       coid: 'reroo' },
     { id: 17,
       job: '195 chestnut',
       category: null,
       active: 0,
       week: 0,
       idx: 17,
       coid: 'reroo' },
     { id: 18,
       job: '40 chestnut ave - alex marburger',
       category: null,
       active: 0,
       week: 0,
       idx: 18,
       coid: 'reroo' },
     { id: 19,
       job: '38 Jamaica',
       category: null,
       active: 0,
       week: 0,
       idx: 19,
       coid: 'reroo' },
     { id: 20,
       job: '18 Holbrook - Everett and Molly',
       category: null,
       active: 0,
       week: 0,
       idx: 20,
       coid: 'reroo' },
     { id: 21,
       job: 'Karen and Duncan - 254 Hawthorne',
       category: null,
       active: 0,
       week: 0,
       idx: 21,
       coid: 'reroo' },
     { id: 22,
       job: 'Terese Hammerle - ',
       category: null,
       active: 1,
       week: 0,
       idx: 22,
       coid: 'reroo' },
     { id: 23,
       job: 'Arbour Hospital',
       category: null,
       active: 1,
       week: 0,
       idx: 23,
       coid: 'reroo' },
     { id: 24,
       job: 'Diana McClure ',
       category: null,
       active: 0,
       week: 0,
       idx: 24,
       coid: 'reroo' },
     { id: 25,
       job: 'Cam Kerry - 21 Adelaide',
       category: null,
       active: 0,
       week: 0,
       idx: 25,
       coid: 'reroo' },
     { id: 26,
       job: 'Nancy Lipamn - Kitteridge Court',
       category: null,
       active: 0,
       week: 0,
       idx: 26,
       coid: 'reroo' },
     { id: 27,
       job: '68 Cypress',
       category: null,
       active: 0,
       week: 0,
       idx: 27,
       coid: 'reroo' },
     { id: 28,
       job: 'Rick Hammond - Liszt St Rosi',
       category: null,
       active: 1,
       week: 0,
       idx: 28,
       coid: 'reroo' },
     { id: 29,
       job: 'Jeanette - Clayborne garden green roof',
       category: null,
       active: 1,
       week: 0,
       idx: 29,
       coid: 'reroo' },
     { id: 30,
       job: '76 South St, Lucy Orloski',
       category: null,
       active: 1,
       week: 0,
       idx: 30,
       coid: 'reroo' },
     { id: 31,
       job: '349 VFW Parkway - Bunny Hickey',
       category: null,
       active: 1,
       week: 0,
       idx: 31,
       coid: 'reroo' },
     { id: 32,
       job: '68 Rockview - terri martell',
       category: null,
       active: 0,
       week: 0,
       idx: 32,
       coid: 'reroo' },
     { id: 33,
       job: 'Jennileen Joseph 218 Neponset Ave',
       category: null,
       active: 1,
       week: 0,
       idx: 33,
       coid: 'reroo' },
     { id: 34,
       job: 'Nathan Lord - 158 Hampshire',
       category: null,
       active: 1,
       week: 0,
       idx: 34,
       coid: 'reroo' },
     { id: 35,
       job: 'South Boston Library - Kathleen Mar',
       category: null,
       active: 0,
       week: 0,
       idx: 35,
       coid: 'reroo' },
     { id: 36,
       job: 'Jodie Wahldesbuhl - 22 Thayer st brookline',
       category: null,
       active: 1,
       week: 0,
       idx: 36,
       coid: 'reroo' },
     { id: 37,
       job: 'Michael Bellefeille - 40 Gartland',
       category: null,
       active: 0,
       week: 0,
       idx: 37,
       coid: 'reroo' },
     { id: 38,
       job: 'Daphnah and Jay - 1435 Centre',
       category: null,
       active: 0,
       week: 0,
       idx: 38,
       coid: 'reroo' },
     { id: 39,
       job: '241-5 Chestnut Ave',
       category: null,
       active: 0,
       week: 0,
       idx: 39,
       coid: 'reroo' },
     { id: 40,
       job: '17 Park Lane',
       category: null,
       active: 0,
       week: 0,
       idx: 40,
       coid: 'reroo' },
     { id: 41,
       job: 'JPNDC brewery',
       category: null,
       active: 0,
       week: 0,
       idx: 41,
       coid: 'reroo' },
     { id: 42,
       job: 'John Stainton - 37 Pondview',
       category: null,
       active: 1,
       week: 0,
       idx: 42,
       coid: 'reroo' },
     { id: 43,
       job: '37 ogden',
       category: null,
       active: 0,
       week: 0,
       idx: 43,
       coid: 'reroo' },
     { id: 44,
       job: '14 chestnut',
       category: null,
       active: 0,
       week: 0,
       idx: 44,
       coid: 'reroo' },
     { id: 45,
       job: 'Dae Kim - 16 Zamora',
       category: null,
       active: 0,
       week: 0,
       idx: 45,
       coid: 'reroo' },
     { id: 46,
       job: '63-65 Chestnut',
       category: null,
       active: 0,
       week: 0,
       idx: 46,
       coid: 'reroo' },
     { id: 47,
       job: '233 Chestnut - Greg Gulickssen',
       category: null,
       active: 0,
       week: 0,
       idx: 47,
       coid: 'reroo' },
     { id: 48,
       job: '126 Thornton - Lucy Lomas',
       category: null,
       active: 0,
       week: 0,
       idx: 48,
       coid: 'reroo' },
     { id: 49,
       job: 'Dee and Maya - Rockview',
       category: null,
       active: 1,
       week: 0,
       idx: 49,
       coid: 'reroo' },
     { id: 50,
       job: 'Michael Hecht - 9 Park Lane',
       category: null,
       active: 1,
       week: 0,
       idx: 50,
       coid: 'reroo' },
     { id: 51,
       job: '241-5 Chestnut Ave',
       category: null,
       active: 0,
       week: 0,
       idx: 51,
       coid: 'reroo' },
     { id: 52,
       job: 'Chestnut Rockview Backwoods',
       category: null,
       active: 0,
       week: 0,
       idx: 52,
       coid: 'reroo' },
     { id: 53,
       job: '11 danforth',
       category: null,
       active: 1,
       week: 0,
       idx: 53,
       coid: 'reroo' },
     { id: 54,
       job: 'connolly library',
       category: null,
       active: 0,
       week: 0,
       idx: 54,
       coid: 'reroo' },
     { id: 55,
       job: 'Marushka Glissen - Lamartine?',
       category: null,
       active: 0,
       week: 0,
       idx: 55,
       coid: 'reroo' },
     { id: 56,
       job: 'Donna Woonteiler - 8 Chetnut Place',
       category: null,
       active: 0,
       week: 0,
       idx: 56,
       coid: 'reroo' },
     { id: 57,
       job: 'J&M Brown',
       category: null,
       active: 0,
       week: 0,
       idx: 57,
       coid: 'reroo' } ]
    }
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
	it("DELETES then POST's jobs for week", function(done){
    const wk = 14
    const jobs = aj.jobs
    .filter((j)=>j.active==1)
    .map((j)=>{return {job: j.job, category: j.category, active: j.active*1, idx: j.idx, week:wk}})
    console.log(jobs);
    var url = httpLoc + 'jobs/post/'+wk
		superagent.post(url)
			.set('Authorization', 'Bearer ' + token)
			.send({jobs: jobs})
			.end(function(e, res) {
				console.log(!!e ? e.status: 'no error')
				//console.log(res.body)
				expect(true).to.equal(true)
				done()
			})    
  })
  it("Puts a revised job record", function(done){
    let jobs = [{
      job: '12parleyvale',
      category: 'utlities',
      active: 0,
      week: 0,
      idx: 5,
      coid: 'reroo' },
    { 
      job: '12parleyvale',
      category: 'stonework',
      active: 0,
      week: 0,
      idx: 5,
      coid: 'reroo' }]
    var url = httpLoc + 'jobs/update'
		superagent.put(url)
			.set('Authorization', 'Bearer ' + token)
			.send({jobs: jobs})
			.end(function(e, res) {
				console.log(!!e ? e.status: 'no error')
				console.log(res.body)
				expect(true).to.equal(true)
				done()
			})      
  })
  it('deletes a job', function(done){
    job ='12parleyvale'
    var url = httpLoc + 'jobs/del'
		superagent.delete(url)
			.set('Authorization', 'Bearer ' + token)
			.send({job: job})
			.end(function(e, res) {
				console.log(!!e ? e.status: 'no error')
				console.log(res.body)
				expect(true).to.equal(true)
				done()
			})  
  })
})
describe('tcard:', function(){
	it('GETs tcard data from api/tcard/week/:wk when passed token', function(done) {
		var url = httpLoc + 'tcard/week/35'
		superagent
			.get(url)
			.set('Authorization', 'Bearer ' + token2)
			.end(function(e, res) {
				console.log(res.body)
				expect(res.body).to.be.an('object');
				done()
			})
  })
  it('PUTs days record back in db if not exists', function(done){
    const nd = JSON.parse('{"wdprt":"2018-W35-5","hrs":9.5,"inout":["7:30","15:15","15:45","17:00","16:12"],"jcost":[{"job":"Eastie Farm","cat":"constr","hrs":2},{"job":"Marketting","cat":"constr","hrs":3},{"job":"HYCC","cat":"constr","hrs":4.5}]}')
    console.log(nd)
    var url = httpLoc + 'tcard/update'
		superagent.put(url)
			.set('Authorization', 'Bearer ' + token2)
			.send({tday: nd})
			.end(function(e, res) {
				console.log(!!e ? e.status: 'no error')
				console.log(res.body)
				expect(true).to.equal(true)
				done()
			}) 
  }) 
})



