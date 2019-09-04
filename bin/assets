#!/usr/bin/env ruby
# frozen_string_literal: true

ENV["RAILS_ENV"] ||= ENV["RACK_ENV"] || "development"
ENV["NODE_ENV"]  ||= ENV["NODE_ENV"] || "development"

require 'pathname'
require 'fileutils'

APP_ROOT = Pathname.new File.expand_path('..', __dir__)
ASSETS_PATH = Pathname.new File.expand_path('./assets', APP_ROOT)
WEBPACK_CONFIG_PATH = Pathname.new File.expand_path('webpack.config.js', ASSETS_PATH)
NODE_MODULES_PATH = Pathname.new File.expand_path('node_modules', ASSETS_PATH)
NODE_MODULES_BIN_PATH = Pathname.new File.expand_path('.bin', NODE_MODULES_PATH)

def system!(*args)
  system(*args) || abort("\n== Command #{args} failed ==")
end

MODE = ARGV[0] == 'compile' ? :compile : :server
PARAMS = (ARGV[1..-1] || [])

FileUtils.chdir ASSETS_PATH do
  puts '== Installing dependencies =='
  system! 'yarn install'

  case MODE
  when :compile
    puts '== Compiling assets =='
    system! "#{NODE_MODULES_BIN_PATH.join('webpack')} --config #{WEBPACK_CONFIG_PATH} --mode=#{ENV['NODE_ENV']} #{PARAMS.join(' ')}".strip
  when :server
    puts '== Running dev server =='
    system! "#{NODE_MODULES_BIN_PATH.join('webpack')} --watch --config #{WEBPACK_CONFIG_PATH} --mode=#{ENV['NODE_ENV']} #{PARAMS.join(' ')}".strip
  end
end
