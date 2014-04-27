Story   = require '../models/story'
Counter = require '../models/counter'
moment  = require 'moment'

module.exports = (app) ->
  # GLOBALS
  app.locals.title = 'azTruyen, truyện gì cũng có, update nhanh nhất'

  # Get all genres of stories
  Story.genres()
  .then (genres) ->
    app.locals.storyGenres = genres

  app.get '/truyen/:slug/', (req, res, next) ->
    Story.findOne()
    .where('slug').equals req.params.slug
    .exec()
    .then (story) ->
      return res.status 404 if story is null
      app.locals.story = story

    res.render 'story'

  ##
  # Homepage
  ##
  app.get '/', (req, res, next) ->
    # Get top-viewed in the current week
    Counter.topViewedStories moment()
    .then (stories) ->
      app.locals.topStories = stories

    # Get latest stories
    Story.latest()
    .then (stories) ->
      app.locals.latestStories = stories

    res.render 'index'
