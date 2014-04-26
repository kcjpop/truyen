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

module.exports = m.model 'Chapter', schema
