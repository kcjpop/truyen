express = require 'express'
routes  = express.Router()
Q       = require 'q'
moment  = require 'moment'

# Load models
Story   = require '../models/story'
Chapter = require '../models/chapter'
Counter = require '../models/counter'

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

##
# View a story
##
routes.get '/truyen/:slug', (req, res, next) ->
  story = req.story
  # Get chapters of this story
  story.getChapters()
  .then (chapters) ->
    story.chapters = chapters
    res.locals.story = story
    res.render 'story'

##
# View a chapter
##
routes.get '/truyen/:slug/chuong-:number-:chapterSlug', (req, res, next) ->
  story = req.story
  # Get chapter
  Chapter.findOne
    sid: story._id
    number: req.params.number
    slug: req.params.chapterSlug
  .exec()
  .then (chapter) ->
    res.locals.story = story
    res.locals.chapter = chapter
    res.render 'chapter'

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
