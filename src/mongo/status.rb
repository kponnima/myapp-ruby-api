require_relative './conection'

def mongo_status
  client = get_mongo_connection
  if client.collections.length >= 1
    'Connection successful'
  else
    abort "Can't find collections"
  end
rescue StandardError
  abort "Failed to connect to Mongo Collection \n"\
    'Try running rake mongo:create or datastore/collections.rb'
end
