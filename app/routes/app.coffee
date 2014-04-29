express = require 'express'
routes  = express.Router()
Q       = require 'q'
Story   = require '../models/story'
Counter = require '../models/counter'
moment  = require 'moment'

# Get all genres of stories
routes.use (req, res, next) ->
  Story.genres()
  .then (genres) ->
    res.locals.storyGenres = genres
    next()

routes.param 'slug', (req, res, next, slug) ->
  Story.findOne slug: slug
    .select '-__v'
    .exec()
    .then (story) ->
      unless story?
        res.status 404
        .send 'Cannot find story with this ID'
      else
        req.story = story
      next()
    , (err) ->
      next err

routes.get '/truyen/:slug', (req, res, next) ->
  story = req.story
  # Get chapters of this story
  story.getChapters()
  .then (chapters) ->
    story.chapters = chapters
    res.locals.story = story
    res.render 'story'

##
# Homepage
##
routes.get '/', (req, res, next) ->
  promises = []
  # Get top-viewed in the current week
  promises.push Counter.topViewedStories moment()
  # Get latest stories
  promises.push Story.latest()

  Q.all promises
  .then (results) ->
    res.locals.topStories    = results[0]
    res.locals.latestStories = results[1]

    res.render 'index'

module.exports = routes
