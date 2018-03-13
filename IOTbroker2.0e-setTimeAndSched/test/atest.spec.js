var expect = require('chai').expect
var cons = require('tracer').console();
var sched =require('../sched')
var my=require('../mysqldb')

const fakeMosca = {
  publish: (packet, cb)=>{
    cb(packet)
  }
}

const mosca = fakeMosca

var pdata={ devid: 'CYURD001', dow: 5, senrel: 1, sched: '[[12,20,77,75]]' }

var query = my.conn.query('INSERT INTO scheds SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
    console.log(query.sql)
    console.log(error)
  }
)



describe('atest.spec  ', function(){
  it('flattenProgObj', function(done){
    var ans = [{dog:'fred'}]
    expect(typeof(ans[0])).to.equal("object");
    done()      
  })
  it('tries fakemos ca', (done)=>{
    mosca.publish({sp:'dog'}, (res)=>{
      console.log(res)
      expect(typeof(res)).to.equal("object");
      done()   
    })    
  })
  it('tries my.dbGetTimezone', (done)=>{
    my.dbGetTimezone('CYURD001', (spot)=>{
      console.log(spot)
      expect(spot).to.equal('America/New_York');
      done()
    })
  })
  it('tries sched.updateTime', (done)=>{
    sched.updateTime('CYURD001', mosca, (dow)=>{
      console.log('dow is ',dow)
      var ans = [{dog:'fred'}]
      expect(typeof(ans[0])).to.equal("object");
      done()  
    })
  })
  it('tries sched.findSched',(done)=>{
    let timeobj =  { dow: 1,
      unix: 1520890988,
      LLLL: 'Monday, March 12, 2018 5:43 PM',
      zone: -4,
      mysql: '2018-03-12 17:43' }
    sched.findSched(timeobj, 'CYURD001', (res)=>{
      console.log(res)
      expect(res.length).to.be.above(0);
      done()
    })
  })
    

  it('tries to get sched',(done)=>{
    var devid='CYURD002'
    var dow = 2
    var query=my.conn.query("SELECT * FROM scheds a INNER JOIN (SELECT MAX(dow)as mdow, senrel FROM scheds WHERE devid=? AND (dow=? OR dow=0 OR dow=8) GROUP BY senrel)b ON a.dow=b.mdow AND a.senrel=b.senrel", [devid,dow], function(error,results,fields){
      console.log(query.sql)
      console.log(results)
      expect(results.length).to.be.above(1);
      done()
    })
  })
  it('tries too addj a hold to sched',(done)=>{
    var pdata={ devid: 'CYURD002', dow: 8, senrel: 3, sched: '[[12,20,1]]', until: '2018-02-11 23:15' }
    var query = my.conn.query('INSERT INTO scheds SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
        console.log(query.sql)
        console.log(error)
        expect(results.affectedRows).to.equal(1);
        done()
      })
  })
  it('tries prints out the date',(done)=>{
    my.dbGetTimezone('CYURD002', function(spot){
      console.log(sched.findNowAtSpot(spot))
      expect(spot).to.equal('America/New_York');
      done()
    })
  })
  it('tries sched.setTimeAndSched',(done)=>{
    sched.setTimeAndSched('CYURD001', mosca, (res)=>{
      cons.log(res)
      expect(res).to.equal('good');
      done()
    })
  })

  it('tries to get sched w hold',(done)=>{
    var devid='CYURD002'
    var dow = 2
    sched.findNowAtDev(devid, (timeobj)=>{
      var query=my.conn.query("SELECT devid, a.senrel, dow, sched, until FROM scheds a INNER JOIN (SELECT MAX(dow)as mdow, senrel FROM scheds WHERE devid=? AND (dow=? OR dow=0 OR (dow=8 AND until>?)) GROUP BY senrel)b ON a.dow=b.mdow AND a.senrel=b.senrel", [devid,dow,timeobj.mysql], function(error,results,fields){
        console.log(query.sql)
        console.log(timeobj)
        console.log(results)
        expect(results.length).to.be.above(1);
        done()
      })
    })
  })
  it('tries sched.combineScheds',(done)=>{
    let res = sched.combineScheds('[[0,0,58,56]]', '[[0,0,64,62], [7,15,69,67], [9,0,63,61], [15,30,68,66], [23,0,63,61]]', '13:43',  )
    console.log(res)
    expect(res.length).to.be.above(1);
    done()
  })
    
})