express = require 'express'
routes = express.Router()

routes.get '/', (req, res, next) ->
  res.send 'GET stories'

routes.get '/:id', (req, res, next) ->
  res.send 'GET stories/'+req.params.id

module.exports = routes
