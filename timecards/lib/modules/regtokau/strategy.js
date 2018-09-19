var jwt = require('jwt-simple');
var cfg = require('../../utilities').cfg
var get = require('../../utilities').get
var conn = require('../../db/mysqldb')
var cons = require('tracer').console();

var bearerTokenApp = function(req, res, next) {
  if (!get('req.headers.authorization', req)) {
    req.userTok = { auth: false, message: "no authorization header", emailId: "" }
    next()
    return
  }
  var toka = req.headers.authorization.split(' ')
  try {
    var tokdata = jwt.decode(toka[1], cfg.secret)
  } catch (e) {
    req.userTok = { auth: false, message: e.message, emailId: "" }
    next()
    return
  }
  conn.query('SELECT w.emailid, w.role, c.coid, c.goodtil, a.appid FROM rolewho w LEFT JOIN co c ON c.coid= w.coid LEFT JOIN `roleapp` a ON a.`role`= w.`role` WHERE w.emailid = ? AND c.goodtil > CURDATE() AND a.appid = ? ', [tokdata.email, tokdata.appId], function(error, results) {
    if (error) {
      req.userTok = { auth: false, message: error.message }
      next()
      return
    }
    if (!results) {
      req.userTok = { auth: false, message: 'no user' }
      next()
      return
    }
    req.userTok = { auth: true, message: 'user has apps', emailid: tokdata.email, appid:tokdata.appId}
    next()
    return
  })
}
var bearerTokenCoid = function(req, res, next) {
  if (!get('req.headers.authorization', req)) {
    req.userTok = { auth: false, message: "no authorization header", emailId: "" }
    next()
    return
  }
  var toka = req.headers.authorization.split(' ')
  try {
    var tokdata = jwt.decode(toka[1], cfg.secret)
  } catch (e) {
    req.userTok = { auth: false, message: e.message, emailId: "" }
    next()
    return
  }
  conn.query('SELECT w.emailid, w.role, c.coid, c.goodtil FROM rolewho w LEFT JOIN co c ON c.coid= w.coid  WHERE w.emailid = ? AND c.goodtil > CURDATE()  AND c.coid = ? ', [tokdata.emailid, tokdata.coid], function(error, results) {
    if (error) {
      req.userTok = { auth: false, message: error.message }
      next()
      return
    }
    if (!results) {
      req.userTok = { auth: false, message: 'no user or active coid' }
      next()
      return
    }
    cons.log('results: ', results)
    req.userTok = { auth: true, message: 'user has apps for coid', emailid: tokdata.emailid, appid:tokdata.appid, coid:tokdata.coid}
    next()
    return
  })
}
module.exports = { bearerTokenApp, bearerTokenCoid }