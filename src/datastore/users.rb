require_relative '../mongo/connection'

module SupportServices
  module DataStore
    class Users
      def initialize(logger)
        @mongo = get_mongo_connection
        @collection = @mongo[:users]
        @logger = logger
      end

      def get_users
        @logger.info('Fetch the list of users')
        @collection.find({ username: 'user' }).first
      end

      def get_user(username)
        @logger.info("Fetch user with username #{username}")
        @collection.find({ username: username }).first
      end

      def create_user(user)
        @logger.info('')

        payload = { name: user['name'], author: user['author']}.compact

        @collection.insert_one(user)
      end

      def create_users(users)
        @logger.info('')
        @collection.insert_many(users)
      end

      def update_user
        @logger.info('')
        result = @collection.update_one({ 'name' => 'Sally' }, { '$set' => { 'phone_number' => '555-555-5555' } })

        puts @collection.find({ 'name' => 'Sally' }).first
      end

      def delete_user
        @logger.info('')
        result = @collection.delete_one({ name: /$S*/ })
        puts result.deleted_count # returns the number of documents deleted
      end
    end
  end
end
