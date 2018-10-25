var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerTokenCoid = require('../regtokau/strategy').bearerTokenCoid

var router = express.Router();
function addAppId(req,res,next){
  req.appid = 'co'
  next()
}
module.exports = function() {
  router.get('/', function(req, res) {
    res.jsonp({ message: "in root of co module" })
  });
  router.get('/co', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in get /co/co (not authorized)-' + req.userTok.message }
        res.jsonp(mess)
    } else {
      var getco = conn.query('SELECT c.*, r.* FROM `timecards`.`cosr` r JOIN `timecards`.`co` c ON c.coid=r.coid AND r.effective <= CURDATE() AND r.coid = ? ORDER BY r.effective DESC LIMIT 1 ', req.userTok.coid, function(error, results) {
        cons.log(getco.sql)
        cons.log(error)
        cons.log(results)
        res.jsonp({results: results[0], binfo: req.userTok})
      })
    }
  })
  router.post('/co', addAppId, bearerTokenCoid, function(req, res) {
    if (!req.userTok.auth) {
        var mess = { message: 'in post /co/co (not authorized)-' + req.userTok.message }
        res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      cons.log('req.body.newco: ', req.body.newco)
      const {newco} = req.body
      let acosr = {...newco}
      delete acosr.id
      acosr.goodtil=req.userTok.goodtil
      acosr.coid =req.userTok.coid
      let aco={}
      const splitnewco = (arr)=>{
        aco.coid = acosr.coid
        arr.map((a)=>{
          aco[a]=acosr[a]
          delete acosr[a]
        })
      }
      splitnewco(['goodtil', 'name', 'street', 'city', 'st', 'zip', 'fedein', 'stein'])
      cons.log('aco: ', aco)
      cons.log('acosr: ', acosr)
      var getco = conn.query('UPDATE `co` SET ? WHERE coid=?; INSERT INTO `cosr` SET ? ON DUPLICATE KEY UPDATE ? ;', [aco, req.userTok.coid, acosr, acosr], function(error, results) {
        cons.log(getco.sql)
        cons.log(error)
        cons.log(results)
        res.jsonp({results, binfo: req.userTok})
      })
    }
  })
  return router
}