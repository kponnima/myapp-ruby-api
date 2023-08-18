# frozen_string_literal: true

require_relative '../datastore/products'

module SupportServices
  module Services
    class Product
      def initialize(logger)
        @logger = logger
      end

      def fetch(params)
        @logger.info 'Request to authenticate the user'
        puts "params #{params}"

      end
    end
  end
end
