# services
## tags
### 21-cassandra
Cassandra is going to be used for devices and senrels that need their time series data stored. So far, there is a tstat_by_day table and a timr_by_month table

* in sitebuilt and parleyvale but not on iotup.stream
* tested in /services/testservice/cassandra.js. 
* cql experiments in services/IOTbroker/cql.js 
* Config is in /etc/cassandra/cassandra.yaml 
* Use single quotes in WHERE clauses.
* 16.04 didn't need java setup but 14.04 did

https://academy.datastax.com/resources/getting-started-time-series-data-modeling

https://www.digitalocean.com/community/tutorials/how-to-run-a-multi-node-cluster-database-with-cassandra-on-ubuntu-14-04

https://hostpresto.com/community/tutorials/how-to-install-apache-cassandra-on-ubuntu-14-04/



You can start Cassandra with sudo service cassandra start and stop it with sudo service cassandra stop. However, normally the service will start automatically. For this reason be sure to stop it if you need to make any configuration changes.
Verify that Cassandra is running by invoking nodetool status from the command line.
The default location of configuration files is /etc/cassandra.
The default location of log and data directories is /var/log/cassandra/ and /var/lib/cassandra.
Start-up options (heap size, etc) can be configured in /etc/default/cassandra.

### 20-store-srstate
For some sensors storing the data would be cool. In https://www.mongodb.com/presentations/mongodb-time-series-data-part-2-analyzing-time-series-data-using-aggregation-framework ~20min in they suggest...

* deviceid:sensorid:timeperiod as _id:  use regular expressions to do a range query. Regex must be left-anchored&case-sensitive /^CYURD001:2:1403/



### 19-dedata-post-prg
Tested in mysql.spec.js and implemented in spas/apoj/rawPaho/utility/saveProg
### 18-getTime-getTodaysSched
Every time you get time you get that days programs too from the mysql scheds table. I think that is the end of using `devid/progs`

    var getTime = function(devid, mosca, cb){
      //var spot="America/Los_Angeles"
      my.dbGetTimezone(devid, function(spot){
          console.log(spot)
          var dow = moment().tz(spot).isoWeekday()
          var nynf = parseInt(moment().tz(spot).format("X"))
          var nyf = moment().tz(spot).format('LLLL')
          var nyz = parseInt(moment().tz(spot).format('Z'))  
          var pkt = {
            unix: nynf,
            LLLL: nyf,
            zone: nyz,
          };    
            console.log(JSON.stringify(pkt))
            var topi = devid+'/devtime'
            var oPacket = {
                topic: topi,
                payload: JSON.stringify(pkt),
                retain: false,
                qos: 0
          };
          console.log(topi) 
          mosca.publish(oPacket, function(){
            console.log('dow is ', dow)
            //var topic = devid+'/prg'
            my.getTodaysSched(devid,dow,function(results){
                results.map((res)=>{
                    cons.log(res)
                    var payload = `{"id":${res.senrel},"pro":${res.sched}}`
                    cons.log(payload)
                        setTimeout(function(){
                            sendSchedule(devid, mosca, payload, (payload)=>{
                                cons.log(payload, ' sent')
                            })
                        }, 1000)                
                })
            })
          });
        })
    }


var sendSchedule= function(devid, mosca, payload, cb){
    var topi = devid+'/prg'
    var oPacket = {
        topic: topi,
        payload: payload,
        retain: false,
        qos: 0
  };
  mosca.publish(oPacket, ()=>{
    cons.log('prg sent')
  });       
} 

### 17-IOTexpress-strategy-handle-no-authorization-header-crash
sched.js now uses my.dbGetTimezone(devid, cb) every time time is checked for device
### 16-IOTexpress-regotoku-IOTbroker-super
fixes super duplicates, and makes super authorized
### 15-added-new-device
both admind and pahoRaw can register
### 14-IOTbroker-authorizePublish
take2
callback true unless topic is prg or cmd


Regarding `authorizePublish` if device its OK. For clients, return false for `cmd` and `prg` when role= `obs` or `any`.
            
    if(res.role=='obs' || res.role=='any'){
        cb(false)
    }

    if(cb){
        callback(null, cb);
    }else{
        if(topic=='cmd' || topic=='prg'){
          callback(null, cb);
        }else{
          callback(null,true)
        }
    }




### 13-IOTbroker-connect-auth
https://github.com/mcollina/mosca/wiki/Authentication-&-Authorization
two types: if client starts with 'CY' then it is a device else client

    const dbAuth = (client, username,password, cb)=>{
        console.log(client.id, username, password)
        if(client.id.substr(0,2)=="CY"){

You can add data to a client but I ended up not using it `(35)client.appId= tokdata.appId` instead I get it from client.id ala `var appId = client.id.split('0.')[0]`. 

For publishing I don't know, to handle observer case maybe just need to block certain topics TBD.

client.connect sends username and token, simple is authenticate, harder is authorize.

For subscribing, if its a device then go ahead subscribe. It ita a client then check for auth in `devuserapp` in `dbPubSub`. 

### 12-IOTexpress-tells-social-auth-no
Where are tables populated from?
In theory..
* unauthorized users can be created by either the superuser or the owner of a device.
* once they log in then they are authorized
* devices are added by the super and given to an owner. At the same time the owner is added to `devuserapp` for that device and each of its apps.
* anybody can try an app and if they are not registered, they can register. When they come back from registering and are authenticated as who they be, if they are not authorized for that app then they won't be able to use it
* putting it another way... `tim@sitebuilt.net` wants to use `pahoRawLo` on the `CYURD007`. `social-auth` enters a record with appid and userid no matter what!!! Is that right??? No, it should only continue with the registration if that user and that app is already registered for some device. If not, `social-auth` should fail!!!  It shouldn't return a token to the spa!!! Spa should deal with it. Maybe spa lets anybody observe the device from that app??? Maybe there is an `observer` role for listed users and an `any` role for anybody to observe???  <s>He can because he is the owner and has had an `devuserapp` record entered for that app and device.</s>

### 11-IOTbroker-dbAuth
broker will authenticate with client.id using username=(owner or user) and passwork=(devpwd or token)
### 10-IOTbroker_IOTexpress-insteadof-geniot
todo-levels of authentication
FIX social-auth so expdays comes from spa app

* you get userName via `authenticate` on connection
* the topic `set` needs to be restricted from all users and can only be published from server
* clients can only subscribe and publish to/from devices in their `devappuser` records
* some clients are only observers and cant change shit. This should be done somehow through the server (they can only req)

dbAuth -two kinds of client.id's, device.id or appid.

* devid.id  uses Devices, database for auth
* appid uses devusersapps for auth


### 09-geniot-bearerToken-dedata/dev+apps
### 08-social-auth-using-cookies
setin /spa/:appid
read in /profile
### 07-social-auth-redploy-w-query-for-facebook


### 06-social-auth-deployed
but
<s>facebook and github have `req.headers.referer` in the callback so you can dig out appId with `mf.parseBetween(req.headers.referer, '/spa/', '?')`. Too bad google and twitter don't have that header.</s> For facebook you can also use the query strategy described here http://blog.pingzhang.io/javascript/2016/09/22/passport-facebook/
https://stackoverflow.com/questions/15513427/can-the-callback-for-facebook-pasport-be-dynamically-constructed

HOORAY deployed as `https://services.sitebuilt.net/soauth` Up on forever, note cd first so all the app redirects work

from sitebuilt.net root/forgone.sh

    fuser -KILL -k -n tcp 7080 # hello
    cd /home/services/social-auth
    export NODE_ENV=production&&forever --uid soauth -a start server.js
    sleep 2

Deals with the fact that facebook and twitter don't need email to register. Decided for the moment not to allow a separate user record with emailid as twitter or facebook userid.

passport can't handle done(err, null) it causes a server fault(500) but it will failure redirect if you use done(null,null). So failure redirects to `cfg.base+message` and which has `res.render(message.ejs, {message: mf.getMessage()` 


### 05-social-auth-deployed-butnotfor-passport
OK fooled around with base path in env.json and package.json. 

* `req.headers.origin` was the only way to get the proper protocol, https:
* pass cfg.base into all the forms so the catch when its souath `%=base %>
signup/`
* added a reverse deploy `copyFromDeploy` for those touchups to the code base that allow you to run multiple services on `https://services.sitebuilt.net`

### 04-social-auth-pre-deploy
ugh
Got rid of passport.use(new ApikeyStrategy)

### 03-geniot-try_catch-middleware
`social-auth` creates a record for a user in devuserapp for the spa that used it. That spa also gets back a token created using the api's secret. 

Since all the heavy lifting and passport stuff has been shuttled of to `social-auth` `modules/regtokau/strategy/bearerToken` just has to intercept a request, grab its token and tell the endware what's up.

#### Middleware 
works like so. Here is what middleware looks like 

    var bearerToken = function(req,res, next){
        ...check token (req.tokenAuth = what's up)
        next()
    }

    router.get('/appsa', bearerToken, function(req,res){
        ... now you can do whatever to the request if req.tokenAuth.auth
        res.jsonp(req.tokenAuth)
    })

It is just like this kind of callback thingy

    router.get('/appsa', function(req,res){
        bearerToken(req,res, function(){
            cons.log(req.tokenAuth)
            res.jsonp(req.tokenAuth)
        })
    })

but cooler

#### try catch
jwt.decode croak on errors like bad or expired tokens so you have to catch them

    try { 
        var tokdata = jwt.decode(toka[1], cfg.secret)
        cons.log(tokdata)
    } catch(e){
        cons.log(e.message)
        req.tokenAuth = {auth: false, message: e.message}
        next()
        return
    } 

## todo
Connnect social-auth to geniot. 