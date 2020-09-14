require_relative '../mongo/connection'

module SupportServices
  module DataStore
    class Products
      def initialize(logger)
        @mongo = get_mongo_connection
        @collection = @mongo[:products]
        @logger = logger
      end

      def get_products
        @logger.info('')
        @collection.find({ name: 'Sally' }).first
      end

      def get_product
        @logger.info('')
        @collection.find({ name: 'Sally' }).first
      end

      def create_product(product)
        @logger.info('')

        payload = { name: product['name'], author: product['author']}.compact

        @collection.insert_one(product)
      end

      def create_products(products)
        @logger.info('')
        @collection.insert_many(products)
      end

      def update_product
        @logger.info('')
        result = @collection.update_one({ 'name' => 'Sally' }, { '$set' => { 'phone_number' => '555-555-5555' } })

        puts @collection.find({ 'name' => 'Sally' }).first
      end

      def delete_product
        @logger.info('')
        result = @collection.delete_one({ name: /$S*/ })
        puts result.deleted_count # returns the number of documents deleted
      end
    end
  end
end
