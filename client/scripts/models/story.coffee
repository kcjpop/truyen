Base = require './base'

model =
  urlRoot: app.apiUrl + '/stories'
  idAttribute: 'slug'
  defaults:
    name    : ''
    slug    : ''
    desc    : ''
    author  : ''
    aliases : ''
    genres  : []
    status  : ''
    added   : new Date()

module.exports = Base.extend model
