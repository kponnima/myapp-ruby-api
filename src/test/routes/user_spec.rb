require_relative '../spec_helper'
require_relative '../../routes/app'

RSpec.describe 'The HelloWorld App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "says hello" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Hello World')
  end
end

# describe 'Root Path' do
#   describe 'GET /' do
#     before { get '/' }

#     it 'is successful' do
#       expect(last_response.status).to eq 200
#     end
#   end
# end
