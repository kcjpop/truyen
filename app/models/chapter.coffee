m = require 'mongoose'

schema = m.Schema
  number  : Number
  name    : String
  sid     : m.Schema.Types.ObjectId # Story ID
  content : String
  added   :
    type: Date
    default: Date.now

module.exports = m.model 'Chapter', schema
