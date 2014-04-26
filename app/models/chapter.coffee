m = require 'mongoose'

schema = m.Schema
  sid     : m.Schema.Types.ObjectId # Story ID
  number  : Number
  name    : String
  slug    : String
  content : String
  views   : # Number of view
    type: Number
    default: 0
  added   :
    type: Date
    default: Date.now

module.exports = m.model 'Chapter', schema
