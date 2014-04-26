module.exports = {
  entry: './public/scripts/app.js',
  output: {
    path: './public/scripts',
    filename: 'bundle.js'
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: 'style!css'},
      { test: /\.coffee$/, loader: 'coffee-loader' },
    ]
  },
  resolve: {
    modulesDirectories: ['../bower_components', 'node_modules']
  }
};
