var mosca = require('mosca')
var cons = require('tracer').console();
var my=require('./mysqldb')
var cfg= my.cfg
console.log(cfg.db)
var currentPacket = {dog: "uli"};
var sched =require('./sched')
var Reco = require('./reco').Reco
var get = require('./utility').get

var mongoose = require('mongoose');
mongoose.connect(cfg.db.url);

const cassandra = require('cassandra-driver');
const cassClient = new cassandra.Client({ contactPoints: ['sitebuilt.net'], keyspace: 'geniot' });

var authenticate = function(client, username, password, callback) {
  console.log(client.id)
  cons.log(username)
  cons.log(password)
  if(!username || !password){
    callback(null,false)
  }else{
    my.dbAuth(client, username,password.toString(), function(authorized){
      console.log('authorized = ', authorized, ',appid = '+ client.appId)
      if (authorized) {
        client.user = username;
      }
      console.log(client.user)
      callback(null, authorized);
    })
  }
  //var authorized = (username === 'tim@sitebuilt.net' && password.toString() === 'freddy');
}

var authorizePublish = function(client, topic, payload, callback) {
  var dev = topic.split('/')[0]
  var topic = topic.split('/')[1]   
  var appId = client.id.split('0.')[0]
  var winp = [dev,appId,client.user]
  switch(true){
    case client.id==dev || dev=='presence':
      callback(null,true)
      break;
    case topic=='cmd' || topic=='prg':
      my.dbPublish(winp, function(cb){
        cons.log(`${client.user} can publish ${dev}/cmd||prg?: ${cb}`)
          if(!cb){
            cons.log('in error for ',cb)
            //callback (new Error('wrong topic'), true)
            callback (null, true)
          }else{
            cons.log('should be true ' ,cb)
            callback(null,cb)
          }
      }) 
      break
    case topic=='set':
      if(client.user==cfg.super){
        cons.log(`${client.user} is super and can publish ${dev}/set`)
        callback(null,true)
      }else{
        my.dbPubSet([dev, client.user], function(cb){
          cons.log(`${client.user} can publish ${dev}/set?: ${cb}`)
          if(!cb){
            callback (new Error('wrong topic'), true)
          }else{
            callback(null,cb)
          }
        }) 
      }
      break
    default:
     callback(null, true)        
  }
}

var authorizeSubscribe = function(client, topic, callback) {
  var dev = topic.split('/')[0]
  var appId = client.id.split('0.')[0]
  //cons.log(client.id, appId, dev, client.user)
  if(client.id==dev){
    callback(null,true)
  }else{
    var winp = [dev,appId,client.user]
    my.dbSubscr(winp, function(cb){
      //cons.log(cb)
      callback(null, cb);      
    })
  }
}

var pubsubsettings = {
  //using ascoltatore
  type: 'mongo',        
  url: 'mongodb://127.0.0.1:27017/mqtt',
  pubsubCollection: 'ascoltatori',
  mongo: {}
};

var moscaSettings = {
  port: cfg.port.mqtt,           //mosca (mqtt) port
  backend: pubsubsettings,//pubsubsettings is the object we created above 
  http: {port: cfg.port.ws, bundle: true, static: './'}    
};
// fired when the mqtt server is ready
function setup() {
  moserver.authenticate = authenticate;
  //moserver.authorizePublish = authorizePublish;
  moserver.authorizeSubscribe = authorizeSubscribe;
  console.log('Mosca server is up and running')
  console.log('device mqtt running on port '+cfg.port.mqtt)
  console.log('browser mqtt over ws port '+cfg.port.ws)
}

var moserver = new mosca.Server(moscaSettings);   //here we start mosca
moserver.on('ready', setup);  //on init it fires up setup()
var moclient= moserver.on('clientConnected', function(client) {
    console.log('client connected', client.id);
    return client;
    //console.log(client)
});

moserver.published = function(packet, moclient, cb) {
  if (packet.topic.indexOf('echo') === 0) {
    return cb();
  }
  var dev = packet.topic.split('/')[0]
  var topic = packet.topic.split('/')[1]
  //var appId = client.id.split('0.')[0]
  //var winp = [dev,appId,client.user]  
  mq.selectAction(packet.topic)
  mq.processIncoming(packet.payload)  
  if(get('moclient.id', moclient)){
    //console.log('client is', moclient.id)
    //console.log(moclient.user)
    var appId = moclient.id.split('0.')[0]
    var winp = [dev,appId,moclient.user] 
    mq.publishAuthorized(packet, winp)  
  }  
  //console.log(client.appid)
  //console.log(client.user)
  //if(client){console.log(client.id)};
  //console.log(packet.topic)

  //mq.publishAuthorized(packet, winp)
  //mq.publish(packet,cb)
  //   var newPacket = {
  //     topic: 'echo/' + packet.topic,
  //     payload: packet.payload,
  //     retain: packet.retain || false,
  //     qos: packet.qos || 0
  //   };
  //   currentPacket= newPacket;
  //   console.log('Pkt',  packet.topic , newPacket.payload.toString());
  //   //console.log(currentPacket.payload.toString())
  //   exports.currentPacket
  //   moserver.publish(newPacket, cb);
  // }
}

var mq = {
  job: '',
  devid: '', 
  selectAction: function(topic){
    var sp = topic.split("/")
    this.devid = sp[0];
    this.job = sp[1];
    //console.log(this.devid, this.job)
    this[this.job]
  },
  publish: function(packet){
    var newPacket = {
      topic: 'echo/' + packet.topic,
      payload: packet.payload,
      retain: packet.retain || false,
      qos: packet.qos || 0
    };
    currentPacket= newPacket;
    // console.log('Pkt',  packet.topic , newPacket.payload.toString());
    //console.log(currentPacket.payload.toString())
    exports.currentPacket
    moserver.publish(newPacket, function(){
      console.log('Pkt',  packet.topic , newPacket.payload.toString());
    });    
  },
  publishAuthorized: function(packet, winp){
    var topic = this.job
    var dev = this.device

    switch(true){
      case topic=='cmd' || topic=='prg':
        console.log(topic)
        console.log(topic=='cmd' || topic=='prg')
        console.log('topic is cmd or prg')
        my.dbPublish(winp, function(cb){
          cons.log(`${winp[2]} can publish ${dev}/cmd||prg?: ${cb}`)
          if(!cb){
            cons.log('in error for cmd||prg')
          }else{
            cons.log('should be true ' )
            //this.publish(packet)
          }
        }) 
        break
      case topic=='set':
        if(client.user==cfg.super){
          cons.log(`${moclient.user} is super and can publish ${dev}/set`)
          //this.publish(packet)
        }else{
          my.dbPubSet([dev, winp[2]], function(cb){
            cons.log(`${winp[2]} can publish ${dev}/set?: ${cb}`)
            if(!cb){
              cons.log('in error for ')
            }else{
              cons.log('should be true ' )
              //this.publish(packet)
            }
          }) 
        }
        break
      default:
        //console.log('in default')
        //this.publish(packet)
    }
    this.publish(packet)
  },
  processIncoming: function(payload){
    switch(true){
      case this.job=="cmd":
        //console.log("cmd")
        break
      case this.job=="time":
        console.log("time")
        sched.getTime(this.devid, moserver)
        break
      case this.job=="sched":
        //console.log("sched")
        //sched.sendSchedule(this.devid, moserver, payload)
        break
      case this.job=="srstate":
        var pl = JSON.parse(payload.toString())
        if (pl.new){
          var devid=this.devid
          var key=devid+":"+pl.id
          Reco.count({id:key}, function(err,count){
            if (count>0){
              var q1,vals,oldrelay
              var d = new Date()
              var iso=d.toISOString()
              var day = iso.split('T')[0]
              var mo =day.substring(0,7)
              var ts = iso.replace('T',' ').split('.')[0]
              if (pl.darr.length==4){
                q1="INSERT INTO tstat_by_day(devid,senrel,date,event_time,temp,relay,hilimit,lolimit) VALUES (?,?,?,?,?,?,?,?);"
                vals=[devid, pl.id,day,ts,pl.darr[0],pl.darr[1],pl.darr[2],pl.darr[3]]
              }else{
                q1="INSERT INTO timr_by_month(devid,senrel,month,event_time,relay) VALUES (?,?,?,?,?);"
                vals=[devid, pl.id,mo,ts,pl.darr[0]]
              }
              cassClient.execute(q1, vals, { prepare: true }, function(err){
                if(err!=null){
                  console.log(err)
                }
              })
            }
          })
        }
        break
      case this.job=="dog":
        //console.log("dog")
        break
      default:
        //console.log("in default")  
        //console.log(this.job)  
    }
  }
}