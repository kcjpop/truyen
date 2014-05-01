module.exports = {
  cache: true,
  entry: __dirname + '/client/scripts/app.coffee',
  output: {
    path: __dirname + '/public/assets',
    publicPath: '/assets/',
    filename: 'bundle.js'
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: 'style!css'},
      { test: /\.coffee$/, loader: 'coffee-loader' },
      { test: /\.(jpg|png|gif|svg|eot|ttf|woff)/, loader: 'file-loader' }
    ]
  },
  resolve: {
    modulesDirectories: [__dirname + '/client/bower_components', 'node_modules'],
    alias: {
      'jquery'     : 'jquery/jquery',
      'hogan'      : 'hogan/web/builds/2.0.0/hogan-2.0.0',
      'semantic-ui': 'semantic-ui/build/packaged/javascript/semantic',
      'backbone'   : 'backbone/backbone',
      'underscore' : 'underscore/underscore',
    }
  }
};
