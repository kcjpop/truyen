m = require 'mongoose'
schema = m.Schema
  name    : String
  slug    : String
  desc    : String
  author  : String
  aliases : [String] # Other names of this title
  genres  : [String] # Its genres
  status  : String   # Ongoing, completed, dropped
  views   : # Number of view
    type: Number
    default: 0
  added   :
    type: Date
    default: Date.now

module.exports = m.model 'Story', schema
