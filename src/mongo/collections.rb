require_relative './connection'
require_relative './status'

def create_collections
  client = get_mongo_connection
  client[:users].create
  client[:products].create
rescue Mongo::Error::OperationFailure => e
  abort e.message unless e.message.includes?('already exists')
  puts 'Collection exists'
end
