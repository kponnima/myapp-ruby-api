# frozen_string_literal: true

# ENV['RACK_ENV'] ||= 'development'
# require 'bundler'
# Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'sinatra/base'
require 'sinatra/param'
require 'sinatra/namespace'
# require 'sinatra/reloader'
require 'sinatra/custom_logger'
require 'logger'
require 'dotenv/load'

require_relative 'routes/product'
require_relative 'routes/user'

module SupportServices
  class App < Sinatra::Base
    # require 'dotenv/load' if development?

    helpers Sinatra::Param
    register Sinatra::Namespace

    # use Rack::Logger
    # set :logger, Logger.new(STDOUT)

    set :root, File.dirname(__FILE__)
    set :raise_errors, false
    set :show_exceptions, false
    # set :show_exceptions, :after_handler
    set :bind, '0.0.0.0'
    set :port, 8081
    set :protection, except: [:json_csrf]
    set :environments, %w[development stage production]
    set :logging, true

    # enable :logging, :sessions, :partial_underscores

    configure :development do
      puts "environment #{environment}"

      enable :logging
      use Rack::Logger
      # register Sinatra::Reloader
      # # also_reload './routes/user'
      # after_reload do
      #   puts 'reloaded'
      # end
    end

    configure :staging, :production do
      enable :logging
      helpers Sinatra::CustomLogger

      puts "environment #{environment}"
      Dir.mkdir("#{root}/log") unless File.exist?("#{root}/log")
      logger = Logger.new(File.open("#{root}/log/#{environment}.log", 'a'))
      logger.level = Logger::DEBUG if development?
      set :logger, logger
    end

    # configure :staging, :production do
    #   set :raise_errors, true
    #   set :show_exceptions, false
    #   set :dump_errors, false

    #   file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
    #   file.sync = true
    #   use Rack::CommonLogger, file
    # end

    namespace '/api/v1' do
      before do
        content_type 'application/json'
        headers 'Access-Control-Allow-Origin' => '*',
                'Access-Control-Allow-Methods' => %w[OPTIONS GET POST PUT DELETE],
                'Access-Control-Allow-Headers' => 'Content-Type'
      end

      register SupportServices::Routing::Product
      register SupportServices::Routing::User
    end

    # $0 is the executed file
    # __FILE__ is the current file
    run! if __FILE__ == $0
  end
end
