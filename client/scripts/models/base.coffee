Backbone = require 'backbone'

model =
  urlRoot: app.apiUrl
  idAttribute: '_id'

module.exports = Backbone.Model.extend model
