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
  it('tries updateTime', (done)=>{
    sched.updateTime('CYURD001', mosca, (dow)=>{
      console.log('dow is ',dow)
      var ans = [{dog:'fred'}]
      expect(typeof(ans[0])).to.equal("object");
      done()  
    })
  })
  it('tries sched.getTimeAndSched',(done)=>{
    sched.getTimeAndSched('CYURD001', mosca, (res)=>{
      console.log(res)
      expect(res[0].sched).to.equal(pdata.sched);
      done()
    })
  })
    
})