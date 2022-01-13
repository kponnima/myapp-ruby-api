require 'mongo'
require 'erb'

OPTIONS = {
  server_selection_timeout: 10,
  min_pool_size: 5,
  max_pool_size: 20,
  connect_timeout: 10
}.freeze

def get_connection_string
  use_atlas = ENV['MONGO_ATLAS'] || false
  host = ENV['MONGO_HOST'] || '127.0.0.1'
  port = ENV['MONGO_PORT'] || '27017'
  db = ENV['MONGO_DB'] || 'myappDB'
  user = ENV['MONGO_USER']
  password = ERB::Util.url_encode(ENV['MONGO_PASSWORD'])
  # password = ENV['MONGO_PASSWORD']
  ssl = ENV['MONGO_SSL'] ? '?ssl=true' : ''

  # use_atlas ? "mongodb+srv://#{user}:#{CGI.escape(password)}@#{host}/#{db}?retryWrites=true&w=majority" : "mongodb:://#{user}:#{password}@#{host}:#{port}/#{db}#{ssl}"
  use_atlas ? "mongodb+srv://#{user}:#{password}@#{host}/#{db}?retryWrites=true&w=majority" : "mongodb:://#{user}:#{password}@#{host}:#{port}/#{db}#{ssl}"
end

def get_mongo_connection
  Mongo::Logger.logger.level = Logger::WARN
  Mongo::Client.new(get_connection_string, OPTIONS)
end
