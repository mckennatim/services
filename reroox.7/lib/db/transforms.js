var mysql = require('mysql')
var jwt = require('jwt-simple');
var cons = require('tracer').console();
// var env = require('../../../env.json')
// var cfg= env[process.env.NODE_ENV||'development']
var cfg = require('../../utilities').cfg
var get = require('../../utilities').get
var conn = require('../../db/mysqldb')
