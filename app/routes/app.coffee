express = require 'express'
routes  = express.Router()
Q       = require 'q'
moment  = require 'moment'

# Load models
Story   = require '../models/story'
Chapter = require '../models/chapter'
Counter = require '../models/counter'

Preload = require '../utils/preload'

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
  promises = []
  # Get top-viewed in the current week
  promises.push Counter.topViewedStories moment()
  # Get latest stories
  promises.push Story.latest()

  Q.all promises
  .then (results) ->
    # Preload
    Preload.add 'topStories', results[0]
    Preload.add 'latestStories', results[1]
    res.locals.Preload = Preload.stringify()

    res.render 'index'

module.exports = routes
