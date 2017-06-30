const cassandra = require('cassandra-driver');
const client = new cassandra.Client({ contactPoints: ['sitebuilt.net'], keyspace: 'geniot' });
const q1="INSERT INTO tstat_by_day(devid,senrel,date,event_time,temp,relay,hilimit,lolimit) VALUES ('CYURD001','0','2017-06-30','2017-06-30 07:21:00',86,0,74,70);"
client.execute(q1)
  .then(result => console.log(result));
const query = "SELECT * FROM tstat_by_day WHERE devid='CYURD001' AND senrel='0' AND date='2017-06-30'";
client.execute(query)
  .then(result => console.log(result));