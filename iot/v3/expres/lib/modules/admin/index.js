var moment = require('moment-timezone');
var express = require('express');
var cons = require('tracer').console();
var conn = require('../../db/mysqldb')
var bearerTokenApp = require('../regtokau/strategy').bearerTokenApp
var bearerTokenAppLoc = require('../regtokau/strategy').bearerTokenAppLoc
var superagent = require('superagent')
// var cfg = require('../../utilities').cfg
// var Reco = require('../../db/models').Reco

var router = express.Router();

module.exports = function() {
  router.get('/', function(req, res) {
    res.jsonp({message: "in root of admin module"})
  });
  router.get('/i/devzones', bearerTokenAppLoc, function(req,res){
    if(!req.userTok.auth){
      var mess={message: 'in get /admin/i/devsones (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)
    }else{
      cons.log(req.userTok);
      cons.log('in /i/devzones no params')
      var q =conn.query('SELECT devs,zones FROM app_loc WHERE appid=? AND locid=?; SELECT * FROM locations WHERE locid=?',[req.userTok.app, req.userTok.loc, req.userTok.loc],  function(error, results){
        cons.log(q.sql)
        console.log('results: ', results)
        if(results.length>0){
          const devs=JSON.parse(results[0][0].devs)
          const devids = Object.keys(devs)
          console.log('devids: ', devids)
          var q2 =conn.query('SELECT devid, `description`, `server`, specs, `owner` FROM devs WHERE devid IN (?)',[devids],  function(error, dres){
            console.log('q2.sql: ', q2.sql)
            console.log('dres: ', dres)
            const zones=JSON.parse(results[0][0].zones)
            const latlng = JSON.parse(results[1][0].latlng)
            const address = results[1][0].address
            const timezone = results[1][0].timezone
            const devtime = moment().tz(timezone)
            const dow = devtime.isoWeekday()
            const tzadj = devtime.format("Z")
            const locdata = {address, latlng, timezone, tzadj}
            locdata.dow=dow
            const specs = dres
            superagent
              .get(`https://api.sunrise-sunset.org/json?lat=${latlng.lat}&lng=${latlng.lng}&formatted=0`)
              .end((e, resu)=>{
                if (true){
                  let sunrise = resu.body.results.sunrise.split('T')[1].slice(0,5)
                  let sunset = resu.body.results.sunset.split('T')[1].slice(0,5)
                  sunrise = timeAdj(sunrise, tzadj)
                  sunset = timeAdj(sunset, tzadj)
                  console.log('sunrise, sunset: ', sunrise, sunset)
                  locdata.sunrise=sunrise
                  locdata.sunset=sunset
                }
                res.jsonp({devs, zones, binfo:{...req.userTok, locdata}, specs})
              })
          })
        }else{
          res.jsonp({message: 'There is no app for that location'})
        }
      })
    }
  })
  router.get('/u/scheds/:devid/:senrel', bearerTokenAppLoc, function(req,res){
    if(!req.userTok.auth){
      var mess={message: 'in get /admin/u/scheds (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)
    }else{
      cons.log(req.userTok);
      cons.log('in /u/scheds params', req.params)
      const {devid, senrel}= req.params
      var q =conn.query('SELECT * FROM scheds WHERE devid=? AND senrel=?;',[devid,senrel],  function(error, results){
        cons.log(q.sql)
        // var arrres = results.map((dev)=>dev.devid)
        res.jsonp({results,binfo:req.userTok})
      })
    }
  })

  router.put('/u/scheds', bearerTokenAppLoc, function(req,res){
    if (!req.userTok.auth) {
      var mess = { message: 'in get /u/scheds (not authorized)-' + req.userTok.message }
      res.jsonp(mess)
    } else {
      const{dev,sr,keys,values}=req.body
      var q =conn.query('DELETE FROM scheds WHERE devid=? AND senrel=?;',[dev,sr],  function(error, results){
        cons.log(q.sql)
        var q2 =conn.query('INSERT INTO scheds (' + keys + ') VALUES ? ',[values],function(error2, results2){
          cons.log(q2.sql)
          res.jsonp({results,results2,binfo:req.userTok})
        })
      })
    }
  })


  router.get('/b/devlist', bearerTokenApp, function(req,res){
    if(!req.userTok.auth){
      var mess={message: 'in get /admin/devlist (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)
    }else{
      cons.log(req.userTok);
      cons.log('in /b/dedata/loclist no params')
      var q =conn.query('SELECT devid FROM devs WHERE owner=? ORDER BY devid',req.userTok.emailId,  function(error, results){
        cons.log(q.sql)
        var arrres = results.map((dev)=>dev.devid)
        res.jsonp({devs:arrres,binfo:req.userTok})
      })
    }
  })
  router.get('/b/dev/:devid', bearerTokenApp, function(req,res){
    if(!req.userTok.auth){
      var mess={message: 'in get /admin/devlist (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)
    }else{
      console.log('in /admin/dev/:devid', req.params)
      cons.log(req.userTok);
      var q =conn.query('SELECT devid,description,specs,owner FROM devs WHERE devid=? AND owner=?', [req.params.devid,req.userTok.emailId], function(error, results){
        cons.log(q.sql)
        res.jsonp({devinfo:results[0], binfo:req.userTok})
      })
    }
  })
  router.get('/b/nextdev/:base', bearerTokenApp, function(req,res){
    if(!req.userTok.auth){
      var mess={message: 'in get /admin/devlist (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)
    }else{
      console.log('in /admin/nextdev', req.params)
      cons.log(req.userTok);
      let likewhat= req.params.base + '%'
      var q =conn.query("SELECT devid FROM devs WHERE devid LIKE ? ORDER BY devid DESC LIMIT 1", likewhat, function(error, results){
        cons.log(q.sql)
        res.jsonp(results[0])
      })
    }
  })
  router.delete('/b/deldev/:devid', bearerTokenApp, function(req,res){
    if(!req.userTok.auth){
      var mess={message: 'in delete /admin/deldev/device (not authoried)-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)
    }else{
      console.log('in delete /admin/deldev/device', req.params)
      let email=req.userTok.emailId;
      let devid= req.params.devid 
      var q =conn.query("DELETE FROM devs WHERE devid = ? AND owner = ?", [devid,email], function(error, results){
        cons.log(q.sql)
        res.jsonp(results)
      })
    }
  })
  router.post('/b/savedev', bearerTokenApp, function(req,res){
    cons.log('in post dev')
    if(!req.userTok.auth){
      var mess={message: 'not authorized-'+req.userTok.message}
      cons.log(mess)
      res.jsonp(mess)
    }else{
      var pdata=req.body
      cons.log(pdata)
      var queryn = conn.query('INSERT INTO devs SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results){
        cons.log(queryn.sql)
        if (error) {
          res.jsonp({message: error})
          throw error;
        }else{
          cons.log(results)
          res.jsonp({message: results})
        }
      })
    }
  })
  return router
}

function timeAdj(time, adj){
  const hr = time.split(':')[0]*1 + adj.split(':')[0]*1
  return `${hr}:${time.split(':')[1]}`
}