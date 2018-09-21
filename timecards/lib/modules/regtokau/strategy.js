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
  const q1 = conn.query('SELECT w.emailid, w.role, c.coid, c.goodtil, a.appid FROM rolewho w RIGHT JOIN `roleapp` a ON a.`role`= w.`role` LEFT JOIN co c ON c.coid= w.coid WHERE w.emailid = ? AND c.goodtil > CURDATE() AND a.appid = ?', [tokdata.email, tokdata.appId], function(error, results) {
    cons.log('results: ', results)
    cons.log('q1.sql: ', q1.sql)
    if (error) {
      req.userTok = { auth: false, message: error.message }
      next()
      return
    }
    if (!results) {
      req.userTok = { auth: false, message: 'no user ' }
      next()
      return
    }
    const cos = results.map((res)=>res.coid)
    req.userTok = { auth: true, message: 'user has apps', emailid: tokdata.email, appid:tokdata.appId, cos:cos}
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
  const qco =conn.query('SELECT w.emailid, w.role, c.coid, c.goodtil, a.appid FROM rolewho w LEFT JOIN `roleapp` a ON a.`role`= w.`role` LEFT JOIN co c ON c.coid= w.coid WHERE w.emailid = ? AND c.goodtil > CURDATE() AND a.appid = ? AND c.coid = ?', [tokdata.emailid, tokdata.appid, tokdata.coid], function(error, results){
    cons.log('qco results: ', results)
    cons.log('qco.sql: ', qco.sql)
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