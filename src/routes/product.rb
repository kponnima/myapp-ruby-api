# frozen_string_literal: true

require 'json-schema'
require 'json'

require_relative '../lib/request_schemas'
require_relative '../services/product'

module SupportServices
  module Routing
    module Product
      def self.registered(app)
        # list all products
        app.get '/products' do
          'List of products!'

          status 200
        end

        # get a single product
        app.get '/product/:product_id' do
          param :product_id, String, required: true

          "Details of particular product #{params['product_id']}!"

          status 200
        end

        # create a new product
        app.post '/product' do
        end

        # update an existing product
        app.put '/product/:id' do
        end

        # delete an item
        app.delete '/product/:id' do
        end

        app.options '/product' do
          200
        end
      end
    end
  end
end
