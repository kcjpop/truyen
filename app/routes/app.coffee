module.exports = (app) ->
  app.get '/', (req, res, next) ->
    res.locals =
      title: 'Welcome to azTruyen'
    res.render 'index'
