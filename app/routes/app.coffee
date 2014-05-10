express = require 'express'
routes  = express.Router()
Q       = require 'q'
moment  = require 'moment'

# Load models
Story   = require '../models/story'

# Get all genres of stories
routes.use (req, res, next) ->
  Story.genres()
  .then (genres) ->
    res.locals.storyGenres = genres
    next()

##
# Homepage
##
routes.get '*', (req, res, next) ->
  res.render 'index'

module.exports = routes
