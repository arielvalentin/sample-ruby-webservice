require_relative '../../test_helper'
require_relative '../../../app/example'
require 'rack/test'
require 'webmock/test_unit'

require 'addressable/uri'
require 'httpclient'

class Example::WebTest < Test::Unit::TestCase
  include FlexMock::TestCase
  include FactoryGirl::Syntax::Methods
  include Rack::Test::Methods

  AssembledApplication = Rack::Builder.parse_file(File.expand_path('../../../../config.ru', __FILE__)).first

  def app
    AssembledApplication
  end

  context 'providing access to accounts' do
    setup do
      stub_request(:any, /www.example.com/).to_rack(AssembledApplication)
    end
    
    should 'provide access to accounts by number' do
      account_params = {name: 'My Account'}
      @http_client = HTTPClient.new

      response = @http_client.post('http://www.example.com/', account_params.to_json, {'Content-Type' => 'application/json'})
      @status = response.status
      @account = JSON.parse(response.body, symbolize_names: true)
      
      assert_equal(201, @status)
      assert_equal('My Account', @account[:name])

      response = @http_client.get("http://www.example.com/#{@account[:number]}", {}, {'Content-Type' => 'application/json'})
      @status = response.status
      @retrieved_account = JSON.parse(response.body, symbolize_names: true)

      assert_equal(200, @status)
      assert_equal(@retrieved_account, @account) 
    end
  end  
end
