Backbone = require 'backbone'

model =
  defaults:
    name    : ''
    slug    : ''
    desc    : ''
    author  : ''
    aliases : ''
    genres  : ''
    status  : ''
    added   : new Date()

module.exports = Backbone.Model.extend model
