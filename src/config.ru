# frozen_string_literal: true

# require './app'
require_relative 'app'

Rack::Handler.default.run(SupportServices::App, Port: 8081, Thread: '1:20')
# run SupportServices::App -e development
# run SupportServices::App