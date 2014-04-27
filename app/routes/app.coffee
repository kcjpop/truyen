Q       = require 'q'
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

  app.get '/truyen/:slug', (req, res, next) ->
    Story.findOne()
    .where('slug').equals req.params.slug
    .exec()
    .then (story) ->
      return res.status 404 if story is null

      # Get chapters of this story
      story.getChapters()
      .then (chapters) ->
        story.chapters = chapters
        app.locals.story = story
        res.render 'story'

  ##
  # Homepage
  ##
  app.get '/', (req, res, next) ->
    promises = []
    # Get top-viewed in the current week
    promises.push Counter.topViewedStories moment()
    # Get latest stories
    promises.push Story.latest()

    Q.all promises
    .then (results) ->
      app.locals.topStories    = results[0]
      app.locals.latestStories = results[1]

      res.render 'index'
