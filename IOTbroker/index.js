var mosca = require('mosca')
var cons = require('tracer').console();
var my=require('./mysqldb')
var cfg= my.cfg
//console.log(cfg.mysql)
var currentPacket = {dog: "uli"};
var sched =require('./sched')

var authenticate = function(client, username, password, callback) {
  console.log(client.id)
  my.dbAuth(client, username,password.toString(), function(authorized){
    console.log('authorized = ', authorized, ',appid = '+ client.appId)
    if (authorized) {
      client.user = username;
    }
    console.log(client.user)
    callback(null, authorized);
  })
  //var authorized = (username === 'tim@sitebuilt.net' && password.toString() === 'freddy');
}

var authorizePublish = function(client, topic, payload, callback) {
  var dev = topic.split('/')[0]
  var topic = topic.split('/')[1]   
  var winp = [dev,appId,client.user]
  var appId = client.id.split('0.')[0]
  switch(true){
    case client.id==dev || dev=='presence':
      callback(null,true)
      break;
    case topic=='cmd' || topic=='prg':
      my.dbPublish(winp, function(cb){
        cons.log(`${client.user} can publish ${dev}/cmd||prg?: ${cb}`)
        callback(null,cb)
      }) 
      break
    case topic=='set':
      if(client.user==cfg.super){
        cons.log(`${client.user} is super and can publish ${dev}/set`)
        callback(null,true)
      }else{
        my.dbPubSet([dev, client.user], function(cb){
          cons.log(`${client.user} can publish ${dev}/set?: ${cb}`)
          callback(null,cb)
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
}

var moserver = new mosca.Server(moscaSettings);   //here we start mosca
moserver.on('ready', setup);  //on init it fires up setup()
moserver.on('clientConnected', function(client) {
    console.log('client connected', client.id);
    //console.log(client)
});

moserver.published = function(packet, client, cb) {
  if (packet.topic.indexOf('echo') === 0) {
    return cb();
  }
  //if(client){console.log(client.id)};
  //console.log(packet.topic)
  mq.selectAction(packet.topic)
  mq.processIncoming(packet.payload)

  var newPacket = {
    topic: 'echo/' + packet.topic,
    payload: packet.payload,
    retain: packet.retain || false,
    qos: packet.qos || 0
  };
  currentPacket= newPacket;
  console.log('Pkt',  packet.topic , newPacket.payload.toString());
  //console.log(currentPacket.payload.toString())
  exports.currentPacket
  moserver.publish(newPacket, cb);
}

var mq = {
  selectAction: function(topic){
    var sp = topic.split("/")
    this.devid = sp[0];
    this.job = sp[1];
    //console.log(this.devid, this.job)
    this[this.job]
  },
  processIncoming: function(payload){
    switch(this.job){
      case "cmd":
        //console.log("cmd")
        break
      case "time":
        console.log("time")
        sched.getTime(this.devid, moserver)
        break
      case "sched":
        //console.log("sched")
        //sched.sendSchedule(this.devid, moserver, payload)
        break
      case "srstate":
        //if (payload.rec)
        ;//console.log("srstate")
        break      
      case "dog":
        //console.log("dog")
        break
      default:
        //console.log("in default")  
        //console.log(this.job)  
    }
  },
  job: '',
  devid: ''
}