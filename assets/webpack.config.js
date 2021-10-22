const path = require('path');
const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require("terser-webpack-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const CopyWebpackPlugin = require('copy-webpack-plugin');
const { WebpackManifestPlugin } = require('webpack-manifest-plugin');
const CompressionPlugin = require('compression-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

const entrypoints = require('./entrypoints.json');

module.exports = (env, options) => {
  const DEBUG = process.env.NODE_ENV === 'development' || options.mode === 'development';
  const POLYFILLS = DEBUG ? [] : ['babel-polyfill', 'es6-promise/auto']
  const ASSETS_PREFIX = process.env.WEB_ASSETS_DIR || '/web-assets'

  return {
    context: __dirname,
    cache: true,
    devtool: DEBUG ? 'source-map' : 'hidden-source-map',
    optimization: {
      minimize: true,
      minimizer: [
        new TerserPlugin({ parallel: true, terserOptions: { sourceMap: false } }),
        new CssMinimizerPlugin({}),
      ]
    },
    entry: Object.fromEntries(entrypoints.map(i => [i, [...POLYFILLS, `./javascripts/${i}.js`, `./stylesheets/${i}.js`]])),
    output: {
      filename: 'javascripts/[name]-[fullhash].js',
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
                "@babel/syntax-dynamic-import",
                "@babel/proposal-object-rest-spread",
                ["@babel/plugin-proposal-class-properties", { "spec": true }]
              ],
              presets: [
                '@babel/react',
                ['@babel/env', {
                  "modules": false,
                  "targets": {
                    "browsers": "> 1%",
                  },
                  "forceAllTransforms": !DEBUG,
                  "useBuiltIns": 'usage',
                  "corejs": 3,
                }]
              ],
              cacheDirectory: true
            }
          }
        }
      ]
    },
    plugins: [
      new MiniCssExtractPlugin({ filename: 'stylesheets/[name]-[fullhash].css' }),
      new CopyWebpackPlugin({
        patterns: [{ from: 'images', to: 'images/[name]-[fullhash][ext]', toType: 'template' }],
      }),
      new CompressionPlugin({ test: [/\.js$/, /\.css$/, /\.svg$/] }),
      new CleanWebpackPlugin({
        cleanOnceBeforeBuildPatterns: [`../public${ASSETS_PREFIX}`],
        verbose: DEBUG,
        watch: DEBUG,
        dry: false,
        dangerouslyAllowCleanPatternsOutsideProject: true,
      }),
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
