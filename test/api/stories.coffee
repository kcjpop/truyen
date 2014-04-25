describe 'Stories API', ->
  app = require '../../server'

  describe 'GET /stories', ->
    it 'should have status 200 and return JSON', (done) ->
      request app
      .get '/api/v1/stories'
      .expect 'Content-Type', /json/i
      .expect 200, done

  describe 'GET /stories/:slug', ->
    it 'should have status 200 and return JSON', (done) ->
      request app
      .get '/api/v1/stories/than-ma-cuu-bien'
      .expect 'Content-Type', /json/i
      .expect 200, done

    it 'should have status 404 and message is not empty if not found', (done) ->
      request app
      .get '/api/v1/stories/never-exist'
      .expect 'Content-Type', /json/i
      .expect 404
      .end (err, res) ->
        res.body.should.not.be.empty
        done()

