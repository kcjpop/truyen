module.exports =
  cache: true
  entry: __dirname + '/client/scripts/app'
  output:
    path: __dirname + '/public/assets'
    publicPath: '/assets/'
    filename: 'bundle.js'
  module:
    loaders: [
      {test: /\.css$/, loader: 'style!css'}
      {test: /\.coffee$/, loader: 'coffee-loader'}
      {test: /\.(jpg|png|gif|svg)/, loader: 'file-loader?prefix=img/'}
      {test: /\.(eot|ttf|woff)/, loader: 'file-loader?prefix=font/'}
    ]
  resolve:
    extensions: ['', '.js', '.coffee', '.html']
    modulesDirectories: [__dirname + '/client/bower_components', 'node_modules']
    alias:
      'jquery'     : 'jquery/jquery'
      'hogan'      : 'hogan/web/builds/2.0.0/hogan-2.0.0'
      'semantic-ui': 'semantic-ui/build/packaged/javascript/semantic'
      'backbone'   : 'backbone/backbone'
      'underscore' : 'underscore/underscore'
