const path = require("path");
var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
  entry: {
    site: ["./assets/javascripts/index.js", "./assets/stylesheets/index.scss"],
  },
  output: {
    filename: "assets/javascripts/[name].js",
    path: path.resolve(__dirname, ".tmp/dist"),
  },
  module: {
    rules: [
      {
        test: /\.m?js$/,
        exclude: /(node_modules)/,
        loader: "babel-loader",
      },
      {
        test: /\.scss$/,
        use: ExtractTextPlugin.extract({
          use: [
            {
              loader: "css-loader", // translates CSS into CommonJS modules
            },
            {
              loader: "postcss-loader", // Run post css actions
              options: {
                postcssOptions: {
                  plugins: ["precss", "autoprefixer"],
                },
              },
            },
            {
              loader: "sass-loader", // compiles Sass to CSS
            },
          ],
        }),
      },
    ],
  },
  plugins: [
    new ExtractTextPlugin({
      filename: "assets/stylesheets/[name].css",
    }),
  ],
};
