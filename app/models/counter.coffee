m = require 'mongoose'

schema = m.Schema
  year  : Number
  month : Number
  week  : Number
  object: String # Object type, e.g 'chapter'
  oid   : m.Schema.Types.ObjectId # Object ID
  views   : # Number of view
    type: Number
    default: 0

module.exports = m.model 'Counter', schema
