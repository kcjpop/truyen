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

schema.set 'toObject', virtuals: true
schema.set 'toJSON', virtuals: true

schema.virtual('url').get ->
  '/chuong-'+@number+'-'+@slug

module.exports = m.model 'Chapter', schema
