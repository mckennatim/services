// var mysql = require('mysql')
var jwt = require('jwt-simple');
//var cons = require('tracer').console();
// var env = require('../../../env.json')
// var cfg= env[process.env.NODE_ENV||'development']
var cfg = require('../../utilities').cfg
var get = require('../../utilities').get
var conn = require('../../db/mysqldb')

var bearerTokenApp = function(req, res, next) {
    if (!get('req.headers.authorization', req)) {
        req.userTok = { auth: false, message: "no authorization header", emailId: "" }
        next()
        return
    }
    var toka = req.headers.authorization.split(' ')
    let appid
    let coid
    try {
        var tokdata = jwt.decode(toka[1], cfg.secret)
        const ja = tokdata.appId.split('-')
        appid = ja[1]
        coid = ja[0]
    } catch (e) {
        req.userTok = { auth: false, message: e.message, emailId: "" }
        next()
        return
    }
    // var retu = 'duch'
    conn.query('SELECT * FROM whoapp WHERE emailid= ? AND appid=? AND coid=?', [tokdata.email, appid, coid], function(error, results) {
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
        req.userTok = { auth: true, message: 'user has apps', emailId: tokdata.email, appId: appid, coId: coid }
        next()
        return
    })
}
module.exports = { bearerTokenApp }