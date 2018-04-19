var http = require('http')
var passport = require('passport');
var env = require('../env.json')
var cfg= env[process.env.NODE_ENV||'development']
var app = require('./cors');
var regtokau = require('./modules/regtokau/regtokau')();
var schedrts = require('./modules/schedule/schedrts')();
var mqtt = require('./modules/mqtt/mqttroutes')();
var dedata = require('./modules/dedata')();
var admin = require('./modules/admin')();

var mongoose = require('mongoose');
mongoose.connect(cfg.db.url);
console.log(cfg.db.url)


app.use('/api/sched', schedrts);
app.use('/api/reg', regtokau);
app.use('/api/mqtt', mqtt);
app.use('/api/dedata', dedata);
app.use('/api/admin', admin);

app.get('/api', function (req,res){
  res.send("<h4>in IOTexpress /api</h4>")
});

app.set('port', cfg.port.express || 3000);
var server = http.createServer(app);

server.listen(app.get('port'), function(){
  console.log('IOTexpress server listening on port ' + server.address().port);
});