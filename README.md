# services
## tags
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