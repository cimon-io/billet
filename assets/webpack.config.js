const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const WebpackManifestPlugin = require('webpack-manifest-plugin');
const CompressionPlugin = require("compression-webpack-plugin");
const CleanWebpackPlugin = require("clean-webpack-plugin");

module.exports = (env, options) => {
  const DEBUG = process.env.NODE_ENV === 'development' || options.mode === 'development';
  const POLYFILLS = DEBUG ? [] : ['babel-polyfill', 'es6-promise/auto']
  const ASSETS_PREFIX = process.env.WEB_ASSETS_DIR || '/web-assets'


  return {
    context: __dirname,
    cache: true,
    devtool: DEBUG ? 'source-map' : 'hidden-source-map',
    optimization: {
      minimizer: [
        new UglifyJsPlugin({ cache: true, parallel: true, sourceMap: false }),
        new OptimizeCSSAssetsPlugin({})
      ]
    },
    entry: {
      stylesheets: [...POLYFILLS, './stylesheets.js'],
      application: [...POLYFILLS, './javascripts/application.js'],
    },
    output: {
      filename: 'javascripts/[name]-[hash].js',
      pathinfo: !!DEBUG,
      path: path.resolve(__dirname, '../public' + ASSETS_PREFIX)
    },
    resolve: {
      extensions: ['.js', '.jsx']
    },
    module: {
      rules: [
        {
          test: /\.scss$/,
          use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader']
        },
        {
          test: /\.(js|jsx)$/,
          exclude: /node_modules/,
          use: {
            loader: 'babel-loader',
            options: {
              plugins: [
                "syntax-dynamic-import",
                "transform-object-rest-spread",
                ["transform-class-properties", { "spec": true }]
              ],
              presets: [
                'env',
                'react',
                {
                  "modules": false,
                  "targets": {
                    "browsers": "> 1%",
                    "uglify": true
                  },
                  "useBuiltIns": true
                }
              ],
              cacheDirectory: true
            }
          }
        }
      ]
    },
    plugins: [
      new MiniCssExtractPlugin({ filename: 'stylesheets/[name]-[hash].css' }),
      new CopyWebpackPlugin([{ from: 'images', to: 'images/[name]-[hash].[ext]', toType: 'template' }]),
      new CompressionPlugin({ test: [/\.js$/, /\.css$/, /\.svg$/], cache: true }),
      new CleanWebpackPlugin(['../public' + ASSETS_PREFIX], { verbose: DEBUG, watch: DEBUG, allowExternal: true }),
      new WebpackManifestPlugin({
        filter: (file) => {
          return (/(.*)\.(gz|map)$/).test(file.name) === false;
        },
        map: (file) => {
          file.name = file.name.replace(/^(.*)\-[a-f0-9]+\.(.*)$/, '$1.$2');
          file.path = ASSETS_PREFIX + '/' + file.path;
          return file;
        }
      })
    ]
  };
};
