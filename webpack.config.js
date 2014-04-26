module.exports = {
  entry: './public/scripts/app.coffee',
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
