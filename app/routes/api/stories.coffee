express = require 'express'
routes = express.Router()

Story = require '../../models/story'

##
# Get all stories
##
routes.get '/', (req, res, next) ->
  # Sort
  sort = if req.query.sort? then req.query.sort else 'name'

  # Allow to filter but not showing _id and __v
  filters = if req.query.filter? then req.query.filter else '-_id -__v'

  # Limit and skip
  limit = if req.query.limit? then req.query.limit else 10
  skip  = if req.query.skip?  then req.query.skip  else 0

  # Return all stories in database
  promise = Story.find()
  .sort sort
  .select filters
  .limit limit
  .skip skip
  .exec()

  # Pagination support
  promise.then (stories) ->
    res.json stories

##
# Get a single story
##
routes.get '/:slug', (req, res, next) ->
  promise = Story.findOne
    slug: req.params.slug
  .select '-_id -__v'
  .exec()

  promise.then (story) ->
    # If cannot find this story
    if story == null
      res.status 404
      .json
        message: 'Cannot find story with this ID'
    else
      res.json story

module.exports = routes
