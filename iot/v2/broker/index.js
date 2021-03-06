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

// const cassandra = require('cassandra-driver');
// const cassClient = new cassandra.Client({ contactPoints: ['sitebuilt.net'], keyspace: 'geniot' });

var authenticate = function(client, username, password, callback) {
  console.log(client.id)
  cons.log(username)
  cons.log(password)
  client.token=password.toString()
  if(!username || !password){
    callback(null,false)
    cons.log('!username or !password')
  }else{
    my.dbAuth(client, username,password.toString(), function(authorized){
      console.log('authorized = ', authorized, ',appid = '+ client.id)
      if (authorized) {
        client.user = username;
      }
      console.log(client.user)
      callback(null, authorized);
    })
  }
}

var authorizePublish = function(client, topic, payload, callback) {
  // cons.log('GOT TO authorizePUBLISH')
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
            cons.log('no publishing for you, connected: ',cb)
            //callback (new Error('wrong topic'), true)
            callback (null, cb)
          }else{
            cons.log('you can publish: ' ,cb)
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
            callback (null,cb)
          }else{
            callback(null,cb)
          }
        }) 
      }
      break
    default:
      // cons.log(appId, topic, ' is approved')
     callback(null, true)        
  }
}

var authorizeSubscribe = function(client, topic, callback) {
  var dev = topic.split('/')[0]
  var appId = client.id.split('0.')[0]
  console.log('CLIENT  TOKEN')
  cons.log('CLIENT: ', client.token)
  cons.log(client.id, dev, appId, client.user)
  if(client.id==dev){
    callback(null,true)
  }else{
    var winp = [dev,appId,client.user]
    my.dbSubscr(winp, function(cb){
      cons.log(cb)
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
  moserver.authorizePublish = authorizePublish;
  moserver.authorizeSubscribe = authorizeSubscribe;
  console.log('Mosca server is up and running')
  console.log('device mqtt running on port '+cfg.port.mqtt)
  console.log('browser mqtt over ws port '+cfg.port.ws)
  var message = {
    topic: '/hello/world',
    payload: 'abcde', // or a Buffer
    qos: 0, // 0, 1, or 2
    retain: false // or true
  };
  moserver.publish(message, function() {
    console.log('done! SUPER SIMPLE');
  });  
}

var moserver = new mosca.Server(moscaSettings);   //here we start mosca
moserver.on('ready', setup);  //on init it fires up setup()
var moclient= moserver.on('clientConnected', function(client) {
    console.log('client connected', client.id, client.user);
    return client;
});

moserver.published = function(packet, moclient, cb) {
  if (packet.topic.indexOf('echo') === 0) {
    return cb();
  }
  console.log('Pkt:',packet.topic,packet.payload.toString())
  mq.selectAction(packet.topic)
  mq.processIncoming(packet.payload)  
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
    cons.log ('PUBLISHED')
    var newPacket = {
      topic: 'echo/' + packet.topic,
      payload: packet.payload,
      retain: packet.retain || false,
      qos: packet.qos || 0
    };
    moserver.publish(newPacket, function(){
      console.log('Pukt',  packet.topic , newPacket.payload.toString());
    });    
  },
  processIncoming: function(payload){
    switch(true){
      case this.job=="cmd":
        break
      case this.job=="time":
        console.log("time")
        sched.setTimeAndSched(this.devid, moserver, (results)=>{
          console.log(results)
        })
        break
      case this.job=="sched":
        break
      case this.job=="user":
        var pl = JSON.parse(payload.toString())
        var top =`${this.devid}/userInf`
        cons.log(pl.user)
        my.dbGetUser([this.devid,pl.appId,pl.user], function(cbv){
          var pla= `{"canPublish":${cbv}}`
          var oPacket = {
            topic: top,
            payload: pla,
            retain: false,
            qos: 0
          };    
          //console.log(oPacket)    
          moserver.publish(oPacket, ()=>{
            cons.log('did PUBLISH IT')
          })          
        })
        break  
      case this.job=="srstate":
        // var pl = JSON.parse(payload.toString())
        // if (pl.new){
        //   var devid=this.devid
        //   var key=devid+":"+pl.id
        //   Reco.count({id:key}, function(err,count){
        //     if (count>0){ 
        //     //if device:srid is stored in mongo.demiot.reco then save to cassandra
        //       var q1,vals,oldrelay
        //       var d = new Date()
        //       var iso=d.toISOString()
        //       var day = iso.split('T')[0]
        //       var mo =day.substring(0,7)
        //       var ts = iso.replace('T',' ').split('.')[0]
        //       if (pl.darr.length==4){
        //         q1="INSERT INTO tstat_by_day(devid,senrel,date,event_time,temp,relay,hilimit,lolimit) VALUES (?,?,?,?,?,?,?,?);"
        //         vals=[devid, pl.id,day,ts,pl.darr[0],pl.darr[1],pl.darr[2],pl.darr[3]]
        //       }else{
        //         q1="INSERT INTO timr_by_month(devid,senrel,month,event_time,relay) VALUES (?,?,?,?,?);"
        //         vals=[devid, pl.id,mo,ts,pl.darr[0]]
        //       }
        //       cassClient.execute(q1, vals, { prepare: true }, function(err){
        //         if(err!=null){
        //           console.log(err)
        //         }else{
        //           cons.log('saved to Cassandra')
        //         }
        //       })
        //     }
        //   })
        // }
        break
      case this.job=="dog":
        break
      default:
    }
  }
}