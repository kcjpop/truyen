chai = require 'chai'
chai.should()

describe 'Test', ->
  it 'should make addition correctly', (done) ->
    a = 1+1
    a.should.be.equals(2)
    done()

  it 'should throw an error', (done) ->
    (new Error('test')).should.exist
    [].should.be.empty
    {}.should.be.empty
    done()