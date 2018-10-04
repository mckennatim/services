var express = require('express');
var jwt = require('jwt-simple');
var moment = require('moment');
var env = require('../../../env.json')
var cfg = env[process.env.NODE_ENV || 'development']
var secret = cfg.secret
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerTokenApp = require('../regtokau/strategy').bearerTokenApp
var bearerTokenCoidApps = require('../regtokau/strategy').bearerTokenCoidApps

var router = express.Router();

module.exports = function() {
  router.get('/', function(req, res) {
    res.jsonp({ message: "in root of registration module" })
  });

  router.post('/auth', function(req, res) {
    cons.log("in api/reg/auth")
    const payload = jwt.decode(req.body.token, secret)
    const emailid = payload.email
    const appid = payload.appId
    cons.log(payload)
    if(appid=='signup'){
      res.jsonp({ auth: true, message: payload.email + ' is authenticating for ' + payload.appId, payload: payload });
    }else{
      const query1 = conn.query('SELECT w.emailid, w.role, c.coid, c.goodtil, a.appid FROM rolewho w RIGHT JOIN `roleapp` a ON a.`role`= w.`role` LEFT JOIN co c ON c.coid= w.coid WHERE w.emailid = ? AND c.goodtil > CURDATE() AND a.appid = ?', [emailid, appid], function(error, results) {
        cons.log('query1.sql: ', query1.sql)
        if (error) {
          res.jsonp({ auth: false, message: 'Sorry, database error ' + error.code + ' occured.' });
        }
        if (results.length == 0) {
          var mes = { auth: false, message: 'You are not authorized for this app for any active business' }
          cons.log(mes)
          res.jsonp(mes);
        } else {
          res.jsonp({ auth: true, message: payload.email + ' is authorized for ' + payload.appId, payload: payload });
        }
      })
    }

  })
  router.get('/coids', bearerTokenApp, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /reg/coids (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      cons.log(req.userTok);
      res.jsonp({ coid: req.userTok.cos, binfo: req.userTok })
    }
  })

  router.get('/apps', bearerTokenCoidApps, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /reg/apps (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      cons.log(req.userTok);
      res.jsonp(req.userTok.results)
    }
  })
  
  router.get('/ctoken/:coid/:role', bearerTokenApp, function(req, res) {
    if (!req.userTok.auth) {
      var mess = { message: 'in get /reg/ctoken/:coid/:role (not authorized)-' + req.userTok.message }
      cons.log(mess)
      res.jsonp(mess)
    } else {
      //res.jsonp({ message: 'in get /reg/ctoken/:coid/:role ' })
      cons.log(req.userTok);
      const exp = Math.floor(Date.now()) + addDays(40)
      var payload = {
        coid: req.params.coid,
        role: req.params.role,
        appid: req.userTok.appid,
        emailid: req.userTok.emailid,
        exp: exp
      };
      var token = jwt.encode(payload, secret);
      res.jsonp({ token: token, binfo: req.userTok, coid:req.params.coid,role: req.params.role})
    }
  })
  router.post('/ckcoid', bearerTokenApp, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /reg/ckcoid (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      cons.log('req.userTok: ', req.userTok)
      cons.log('req.body: ', req.body) 
      var query = conn.query('SELECT coid FROM `timecards`.`co` WHERE coid=?', req.body.co.coid, function(error, copman) {
          cons.log(query.sql)
          cons.log(error)
          if(copman.length>0){
            res.jsonp({message: 'coid already exists, try another' })
          }else{
            const goodtil = moment().add(30, 'days').format('YYYY-MM-DD')
            const effective = moment().format('YYYY-MM-DD')
            var query2 = conn.query("INSERT INTO `timecards`.`co` (goodtil, coid) VALUES(?,?); INSERT INTO `timecards`.`rolewho` (role, emailid, coid,active) VALUES('partner',?,?,1); INSERT INTO `timecards`.`persons` (emailid, coid, effective) VALUES(?,?,?); INSERT INTO `timecards`.`cosr` (coid, effective) VALUES(?,?); ", [goodtil, req.body.co.coid, req.body.co.emailid, req.body.co.coid, req.body.co.emailid, req.body.co.coid, effective, req.body.co.coid, effective], function(error2, result) {
              cons.log(query2.sql)
              cons.log(error2)
              cons.log(result)
              const exp = Math.floor(Date.now()) + addDays(40)
              cons.log('exp: ', exp)
              var payload = {
                coid: req.body.co.coid,
                role: 'partner',
                appid: 'signup',
                emailid: req.body.co.emailid,
                exp: exp
              };
              var token = jwt.encode(payload, secret);
              res.jsonp({message: 'ok setting you up', goodtil:goodtil,result:result, token:token, emailid:req.body.co.emailid})
            })
          }
      })  
    }
  })

  return router;
}

function addDays (x){
  return x*(24*60*60*1000)
}