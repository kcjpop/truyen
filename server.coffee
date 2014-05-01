express = require 'express'
app     = express()
port    = process.env.PORT || 3333

# Config
konfig = require 'konfig'
global.config = konfig path: './app/config'

# Connect to database
mongoose = require 'mongoose'
mongoose.connect global.config.database.url

# Some settings
app.set 'view engine', 'html'            # To use .html extention for templates
app.set 'views', __dirname+'/app/views'  # Set `views` folder
app.set 'layout', 'layout/master'
app.set 'partials',
  header: 'partials/header'
  head  : 'partials/head'
  js    : 'partials/js'
  footer: 'partials/footer'
app.engine 'html', require 'hogan-express'
app.use express.static __dirname+'/public'

# Set up routes
app.use '/api/v1/stories', require './app/routes/api/stories'
app.use '/api/v1/chapters', require './app/routes/api/chapters'

# Expose Config to views
app.locals.Config = global.config

# Homepage
app.use '/', require './app/routes/app'

app.listen port
console.log 'Server is now running at port '+port

module.exports = app
