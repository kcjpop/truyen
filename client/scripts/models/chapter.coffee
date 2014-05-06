B = require './base'

model =
  urlRoot: app.apiUrl + '/chapters'

  idAttribute: '_id'

  defaults:
    sid     : ''
    number  : 0
    name    : ''
    slug    : ''
    content : ''
    added   : new Date

module.exports = B.extend model
