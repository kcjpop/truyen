module.exports = {
  entry: './client/scripts/app.coffee',
  output: {
    path: './public',
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
    modulesDirectories: ['../bower_components', 'node_modules']
  }
};
