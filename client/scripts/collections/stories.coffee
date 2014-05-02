Base  = require './base'
Story = require '../models/story'

col =
  url: app.apiUrl + '/stories'
  model: Story

module.exports = Base.extend col
