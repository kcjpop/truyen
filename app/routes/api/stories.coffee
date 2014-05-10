express = require 'express'
routes = express.Router()

Story = require '../../models/story'

##
# Define chapters as sub-resource
##
routes.use '/:slug/chapters', require './stories.chapters'

##
# Get story by slug
##
routes.param 'slug', (req, res, next, slug) ->
  Story.findOne slug: slug
  .select '-__v'
  .exec()
  .then (story) ->
    unless story?
      res.status 404
      .json message: 'Cannot find story with this ID'
    else
      req.story = story
    next()
  , (err) ->
    next err

##
# Get all stories
##
routes.get '/', (req, res, next) ->
  # Sort
  sort = if req.query.sort? then req.query.sort else 'name'

  # Allow to filter but not showing _id and __v
  fields = if req.query.fields? then req.query.fields else '-_id -__v'

  # Limit and skip
  limit = if req.query.limit? then req.query.limit else 25
  skip  = if req.query.skip?  then req.query.skip  else 0

  # Return all stories in database
  query = Story.find()
  .select fields
  .sort sort
  .limit limit
  .skip skip

  # @todo: Think about a generic way to allow filters like this
  if req.query.genre? and req.query.genre.length > 0
    query.where 'genres'
    .in [req.query.genre.trim()]

  query
  .exec()
  .then (stories) ->
    res.json stories

##
# Get a single story
##
routes.get '/:slug', (req, res, next) ->
  res.json req.story

module.exports = routes
