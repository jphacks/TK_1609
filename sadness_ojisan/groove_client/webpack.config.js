const webpack = require('webpack');
module.exports = {
  entry: './src/main.js',
  output: {
    filename: './dist/build.js'
  },
  devtool: 'inline-source-map',
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      {
        test: /\.vue$/,
        loader: 'vue'
      },
      {
        test: /\.css$/,
        loader: 'style-loader!css-loader'
      },
      {
        test: /\.(jpg|png|woff|woff2|eot|ttf|svg)$/,
        loader: 'url?limit=150000'
      }
    ]
  },
  plugins: [
    new webpack.ProvidePlugin({
        jQuery: "jquery",
        $: "jquery"
    })
  ],
  resolve: {
  }
}
