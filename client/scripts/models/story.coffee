Base = require './base'

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

module.exports = Base.extend model
