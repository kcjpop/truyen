Story = require '../../app/models/story'

describe 'Story model', ->
  it 'should be able to get all genres of all stories', (done) ->
    promise = Story.genres()
    promise.then (genres) ->
      genres.should.be.an.Array
      genres.should.not.be.empty
      genres.should.have.length(6)
      done()
