# frozen_string_literal: true

require 'json-schema'
require 'json'

require_relative '../lib/request_schemas'
require_relative '../services/user'

module SupportServices
  module Routing
    module User
      def self.registered(app)
        # list all users
        app.get '/users' do
          logger.info 'Request to fetch the list of users'

          users = Services::User.new(logger).fetch_users

          status 200
          body users.to_json
        end

        # get a single user
        app.get '/user/:user_id' do
          param :user_id, String, required: true

          "Details of particular user #{params['user_id']}!"

          status 200
        end

        # create a new user
        app.post '/user' do
        end

        # update an existing user
        app.put '/user/:id' do
        end

        # delete an item
        app.delete '/user/:id' do
        end

        app.options '/user' do
          200
        end

        # authenticate an user
        app.post '/user/authenticate' do
          logger.info 'Request to authenticate the user'

          request.body.rewind
          data = JSON.parse request.body.read

          puts 'Authenticate user!'
          JSON::Validator.validate!(Schemas::AUTHENTICATE_USER, data)
          # errors = JSON::Validator.fully_validate(Schemas::AUTHENTICATE_USER, data)
          # puts errors

          Services::User.new(logger).authenticate(data)

          status 200
        rescue JSON::Schema::ValidationError => e
          halt 400, { error: e.message }.to_json
        end

        app.options '/user/authenticate' do
          200
        end
      end
    end
  end
end
