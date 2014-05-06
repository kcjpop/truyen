_       = require 'underscore'
url     = require 'url'
Q       = require 'q'
express = require 'express'
routes  = express.Router()

Chapter = require '../../models/chapter'

concatQuery = (query) ->
  pairs = (key+'='+value for key, value of query)
  pairs.join '&'

routes.get '/', (req, res, next) ->
  # Pagination
  page = if req.query.page? then +req.query.page else 1
  limit = 20
  skip = (page - 1) * limit

  promises = []

  # Count total chapters
  promise = Chapter.count sid: req.story._id
  .exec()
  .then (count) ->
    # There is no pagination here
    return if count <= limit

    pagination = {}
    pagination.total = Math.ceil count / limit

    path = '/stories/'+req.story.slug+'/chapters'
    if page * limit <= count
      query = req.query
      query.page = page + 1
      pagination.next = path + '?' + concatQuery(query)

    if page - 1 >= 1
      query = req.query
      query.page = page - 1

      pagination.previous = path + '?' + concatQuery(query)
    return pagination

  promises.push promise


  promise = Chapter.find sid: req.story._id
  .sort 'number'
  .select '-content -__v'
  .skip skip
  .limit limit
  .exec()
  promises.push promise


  Q.all promises
  .then (results) ->
    # Data returned to server
    json = {}
    json.data = results[1]

    unless _.isEmpty results[0]
      json.paging = results[0]

    res.json json


module.exports = routes
