m = require 'mongoose'

schema = m.Schema
  sid     : m.Schema.Types.ObjectId # Story ID
  number  : Number
  name    : String
  slug    : String
  content : String
  added   :
    type: Date
    default: Date.now

schema.post 'init', (doc) ->
  doc.url = '/chuong-'+doc.number+'-'+doc.slug

module.exports = m.model 'Chapter', schema
