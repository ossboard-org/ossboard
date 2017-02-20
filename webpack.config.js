var path = require("path"),
    webpack = require("webpack"),
    StatsPlugin = require("stats-webpack-plugin"),
    ExtractTextPlugin = require("extract-text-webpack-plugin");

var devServerPort = process.env.WEBPACK_DEV_SERVER_PORT,
    devServerHost = process.env.WEBPACK_DEV_SERVER_HOST,
    publicPath = process.env.WEBPACK_PUBLIC_PATH;

var config = {
  target: 'node',
  entry: {
    web: "./apps/web/assets/javascripts/main.js",
    admin: "./apps/admin/assets/javascripts/main.js"
  },

  output: {
    path: path.join(__dirname, "public"),
    filename: "[name]-[chunkhash].js"
  },

  resolve: {
    root: path.join(__dirname, "apps")
  },

  plugins: [
    new StatsPlugin("webpack_manifest.json")
  ],

  loaders: [
    {
      test: /\.scss$/,
      loaders: ["style-loader", "css-loader", "sass-loader"]
    }
  ],

  module: {
    loaders: [{
      test: /\.js$/,
      exclude: /node_modules/,
      loader: 'babel',
      query: {
        presets: ['es2015']
      }
    },
    {
      test: /\.scss$/,
      loaders: ["style-loader", "css-loader", "sass-loader"]
    },
    { test: /\.json$/, loader: "json-loader" }
    ]
  }
};

if (process.env.INBUILT_WEBPACK_DEV_SERVER === 'true') {
  config.devServer = {
    port: devServerPort,
    headers: { "Access-Control-Allow-Origin": "*" }
  };
  config.output.publicPath = "//" + devServerHost + ":" + devServerPort + "/";
}

if (process.env.INBUILT_WEBPACK_DEV_SERVER === 'false') {
  // config.plugins.push(new webpack.optimize.UglifyJsPlugin({ minimize: true }))
  config.plugins.push(new ExtractTextPlugin("[name].css"))
  config.loaders = [
    {
      test: /\.s?css$/, 
      loader: ExtractTextPlugin.extract("style-loader", "css!sass")
    }
  ]
  config.module.loaders = [{
    test: /\.js$/,
    exclude: /node_modules/,
    loader: 'babel',
    query: {
      presets: ['es2015']
    }
  },
  {
    test: /\.s?css$/, 
    loader: ExtractTextPlugin.extract("style-loader", "css!sass")
  }]
}

module.exports = config;
