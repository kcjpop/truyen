module.exports = {
  entry: __dirname + '/client/scripts/app.coffee',
  output: {
    path: __dirname + '/public',
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
    modulesDirectories: [__dirname + '/client/bower_components', 'node_modules']
  }
};
