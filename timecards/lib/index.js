var http = require('http')
    // var passport = require('passport');
var env = require('../env.json')
var cfg = env[process.env.NODE_ENV || 'development']
var app = require('./cors');
var regtokau = require('./modules/regtokau/regtokau')();
var jobs = require('./modules/jobs')();
var tcard = require('./modules/tcard')();
var payroll = require('./modules/payroll/payroll')();

// dog = 'fred'

app.use('/api/reg', regtokau);
app.use('/api/jobs', jobs);
app.use('/api/tcard', tcard);
app.use('/api/payroll', payroll);

app.get('/api', function(req, res) {
    res.send("<h4>in timecards server /api</h4>")
});

app.set('port', cfg.port.express || 3000);
var server = http.createServer(app);

server.listen(app.get('port'), function() {
    console.log('timecards server listening on port ' + server.address().port);
});