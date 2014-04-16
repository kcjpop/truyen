express = require 'express'
routes = express.Router()

routes.get '/', (req, res, next) ->
    res.send 'GET chapters'

module.exports = routes