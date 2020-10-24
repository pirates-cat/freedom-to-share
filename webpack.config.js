const path = require("path")
const ExtractTextPlugin = require("extract-text-webpack-plugin")

module.exports = {
  entry: {
    site: ["./assets/javascripts/index.js", "./assets/stylesheets/index.scss"],
  },
  output: {
    filename: "assets/javascripts/[name].js",
    path: path.resolve(__dirname, ".tmp/dist"),
  },
  devtool: "source-map",
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
              loader: "css-loader",
            },
            {
              loader: "postcss-loader", // Run post css actions
              options: {
                postcssOptions: {
                  ident: "postcss",
                  plugins: [require("tailwindcss"), require("autoprefixer")],
                },
              },
            },
            {
              loader: "resolve-url-loader",
            },
            {
              loader: "sass-loader",
            },
          ],
        }),
      },
      {
        test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
        use: [
          {
            loader: "file-loader",
            options: {
              name: "[name].[ext]",
              outputPath: "/assets/stylesheets/fonts",
              esModule: false,
            },
          },
        ],
      },
    ],
  },
  plugins: [
    new ExtractTextPlugin({
      filename: "assets/stylesheets/[name].css",
    }),
  ],
}
