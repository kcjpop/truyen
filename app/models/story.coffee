m = require 'mongoose'
schema = m.Schema
    name    : String
    slug    : String
    desc    : String
    author  : String
    url     : String
    aliases : [String] # Other names of this title
    genres  : [String] # Its genres
    chapters: Number   # The number of chapters
    status  : String   # Ongoing, completed, dropped
    added   : 
        type: Date
        default: Date.now

module.exports = m.model 'Story', schema