B = require './base'

model =
  urlRoot: app.apiUrl + '/chapters'
  defaults:
    sid     : ''
    number  : 0
    name    : ''
    slug    : ''
    content : ''
    added   : new Date

module.exports = B.extend model
