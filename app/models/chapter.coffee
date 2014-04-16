m = require 'mongoose'

schema = m.Schema
    number  : Number
    name    : String
    storyId : m.Schema.Types.ObjectId
    content : String
    added   : 
        type: Date
        default: Date.now

module.exports = m.model 'Chapter', schema