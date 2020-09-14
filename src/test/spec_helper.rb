ENV['APP_ENV'] = 'test'

require 'rspec'
require 'rack/test'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

# require_relative File.join('..', 'app')

# RSpec.configure do |config|
#   include Rack::Test::Methods

#   def app
#     SimpleApp
#   end
# end
