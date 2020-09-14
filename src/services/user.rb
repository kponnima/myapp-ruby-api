# frozen_string_literal: true

require_relative '../datastore/users'

module SupportServices
  module Services
    class User
      # def initialize
      # end
      def initialize(logger)
        @logger = logger
        @data_store = DataStore::Users.new(logger)
      end

      def fetch_users
        @logger.info 'Request to authenticate the user'
        users = @data_store.get_users

        puts "users #{users}"
        users
      end

      def authenticate(params)
        @logger.info 'Request to authenticate the user'
        puts "params #{params}"

        users = @data_store.get_user(params[:username])

        puts "users #{users}"
        users
      end
    end
  end
end
