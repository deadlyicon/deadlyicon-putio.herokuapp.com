require('./environment');
var Webpack = require('webpack');
var path = require('path');
var nodeModulesPath = path.resolve(__dirname, 'node_modules');
var assetsPath = path.resolve(__dirname, 'public', 'assets');
var clientPath = path.resolve(__dirname, 'client');


var processEnv = {};
for (var key in process.env){
  processEnv[key] = JSON.stringify(process.env[key]);
}

module.exports = {
  // Makes sure errors in console map to the correct file
  // and line number
  // devtool: 'eval',

  entry: [
    clientPath
  ],

  output: {
    path: assetsPath,
    filename: 'client.js',
    publicPath: '/assets/'
  },

  module: {
    loaders: [
      { test: /\.css$/,    loader: 'style!css'},
      { test: /\.coffee$/, loader: "coffee-loader" },
    ]
  },

  resolve: {
    extensions: ["", ".coffee", ".js", ".css"]
  },

  plugins: [
    new Webpack.DefinePlugin({
      "process.env": processEnv
    }),
  ]
};



// process.env.NODE_ENV)
