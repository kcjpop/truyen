describe 'Chapter API', ->
  app = require '../../server'

  it 'should return a chapter', (done) ->
    request app
    # .get '/api/v1/chapters/535ba620203cf22b09585089'
    .get '/api/v1/chapters/535a3da359ce6f75f27d763a'
    .expect 'Content-Type', /json/i
    .expect 200
    .end (err, res) ->
      chapter = res.body
      chapter.should.not.be.empty
      chapter.name.should.not.be.empty
      done()

  it 'should return 500 if provided an invalid ID', (done) ->
    request app
    .get '/api/v1/chapters/500'
    .expect 500
    .end (err, res) ->
      res.body.message.should.be.equals 'Invalid chapter ID'
      done()

  it 'should return 404 if cannot find chapter', (done) ->
    request app
    .get '/api/v1/chapters/535ba620203cf22b09585089'
    .expect 404, done
