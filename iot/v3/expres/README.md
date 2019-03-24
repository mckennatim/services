# iot summary
## version 3 v3
There is no compelling reason the change brokers authenticate or authorize. 
### table analysis
* `devs` has one to one on device to owners and has locid
* `user_app_loc` has all types of users, apps, auth and roles. _A reasonable change to consider is replacing devicid with locid_. What are the implications? 

broker
* broker/authenticate/dbAuth(device) `"SELECT devid, devpwd, owner FROM devs WHERE devid=?"` checks for match to depwd and devid
* broker/authenticate/dbAuth(appid.random) `if(tokdata.appId==clientid && tokdata.email==username)` no db call unless anybody
* broker/authorizeSubsribe/dbSubscr  There are 2 kinds of subscribe, 
   1. devices subscribing to broker/apps `STATE.cpp/labels_t::scribedTo[] ={"devtime", "cmd", "prg", "req", "set", "progs"};` These are handled by `if(client.id==topic.split('/')[0])` since the client.id of a device is its devid else...
   2. apps subscribing to devices. Now theoretically the app is only connected to this device due to some data it has about which devices are associated with this app@loc. So we don't care if deviceid is in the database query. All we need to know is that it is OK for this device to be subscribed to by the app@loc for this user and that its owner says it is OK. appid, locid and emailid can come from the token  If token.appid== `client.id.split('0.')[0]` and  `"SELECT * FROM app_loc_user WHERE locid=tok.locid AND appid=tok.appid AND userid=tok.userid"` looks for auth as true (pesumably owner of app@loc can click access on and off)
* broker/authorizePublish Same argument as above, 4 kinds of publish.
   1. `case client.id==dev || dev=='presence'`: a) `if(client.id==topic.split('/')[0])` since the client.id of a device is its devid. b) anybody can publish `presence`
   2. `case topic=='cmd' || topic=='prg'`: /dbPublish not OK for `obs` or `any` roles
   3. `case topic=='set'`: /dbSet `"SELECT * FROM app_loc_user WHERE locid=tok.locid AND userid=tok.emailid AND appid=tok.appid and role= 'admin'"`

This will probably fuck up builder and installer (and hvac and timr but who cares). `app_loc` becomes increasingly important. 

* soauth: any records from a query to `app_loc_user` indicate to soauth that yes you are who you say you are and yes we should tell signin that you are good to go since there is at least one location for this appid/user
* signin: The callback comes back to #registered and
   1. if there is a message then registered shows a shit outa luck message otherwise
   2. put the token in ls and route to /#locs then fetch the locations/apps from expres. On click on a location switch to /#apps/:loc.
   3. Clicking on a app@loc fetches a new token that the app can use. It will have appid,locid & userid in it and be saved in ls as appid:{emailid, token:blaslldldl}. Now signin is done and it routes you to the app you selected
* an_app: 
   1. check the local storage for a record else return to signin or on success
   2. fetch the app_loc information for the app@location.  Now you have devs and zones info to work with. Now you can...
   3. Set up paho mqqt. 
      * `client = new Paho.MQTT.Client(cfg.url.mqtt_server, cfg.url.mqtt_port, cfg.appid+Math.random()`
      * `connect({... userName: emailid, password: token})`
      * map over the devices used for the app@location. 
         1. `onConnect()` subscribe, and `publish(req, '{"id":0,"req":"srstates"}')` + whatever other req's you need to make.
         2. All the devices/topics subscribed to and shit that the app publishes to those devices share (hopefully) the username/emailid and password/token.
      * Everything works display a /#frontpage like hvac.parleyvale and link it live to the data
      * click on a deviceunit zone and goto /zone/:azone
      * /zone/:azone goves you ways to temporarily boost or modify a program with a hold or an insertion and lists the prog for the day.
      * /zoneprog/:azone prog every day for that zone
      * /shareprogs lets you copy a zones prog to tother zones
      * /allprogs tell you wwhats up for the whole location

edge cases:

signin: 
1. if no ls token goto /#register and tell them to register
1. if you start on signin/locs or signin/apps/:loc and no token got /#register
2. If callback to /#registered has message tell thenm shit outa luck
2. If callback has token you are not in an edge case.

an_app:
1. anytime there is no token in ls send them back to a /signin with a message on where they came from and that htey need to re-register


soauth
* express/reg/auth `'SELECT * FROM user_app_loc  WHERE userid = ? AND appid = ?'` any returned record means this user is authorized for this app somewhere

broker
* broker/authenticate/dbAuth(device) `"SELECT devid, devpwd, owner FROM devs WHERE devid=?"` checks for match to depwd and devid
* broker/authenticate/dbAuth(appid.random) `if(tokdata.appId==clientid && tokdata.email==username)` no db callunless anybody
* broker/authorizeSubsribe/dbSubscr `winp = [dev,appId,client.user]` gets appid from `client.id.split('0.')[0]`,userid from client.user, devid from `topic.split('/')[0]  "SELECT * FROM user_app_loc WHERE devid=? AND appid=? AND userid=?"` and looks for auth as true(pesumably owner of app@loc can click access on and off)
* broker/authorizeSubsribe/dbPublish `winp = [dev,appId,client.user]` gets appid from `client.id.split('0.')[0]`,userid from client.user, devid from `topic.split('/')[0]  "SELECT * FROM user_app_loc WHERE devid=? AND appid=? AND userid=?"` and looks for role not `obs` or `any` (should probably check auth too)

express
* whatever it does need regrooving



# IOTexpress
express part of what used to be geniot
## todo

redo bearer strategy as middleware, chuck passport.
possible messages from bearerToken(req, res, next)

req.tokenAuth =
{auth: false, message: 'token expired'}
{auth: false, message: 'token defective'}
{auth: false, message: 'no user'}
{auth: true, message: 'user has apps', apps:{}}
{auth: true, message: 'user has no apps'}

Bearer strategy should return all the devuserapp records for an email address or if none the failure

* What should be in the user database?
* What should be in the device data file?
* relational or object?

* each device can rum one o0r more apps
* each user controlls certain devices
* device owner decides who can veiw, modify or admin each of its devidces
* device has  devid, devpwd, owner, location, timezone, server:port, sensor type, apps: [{appId, users:[{user, priveledges}]}]
* user has email and devices: [{devid, apps:[appid, auth:true/false, priveledge]}]

* user goes to iot portal and after authenticating is shown a list of devices and apps they are registered for.
* owner invites a user to use a device and (some/all of its) apps by email linkto iot portal
* there is an owner/admin page where you can register a device and add users for its apps
* super declared in env.json
* if registered is super then goto superapp  