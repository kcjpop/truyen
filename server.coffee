express = require 'express'
app     = express()
port    = process.env.PORT || 3333

app.get '/', (req, res) ->
    res.send 'Hello World'

# Set up routes
app.use '/api/v1/stories', require './app/routes/stories'
app.use '/api/v1/stories/:storyId/chapters', require './app/routes/stories.chapters'
app.use '/api/v1/chapters', require './app/routes/chapters'

app.listen port
console.log 'Server is now running at port '+port;