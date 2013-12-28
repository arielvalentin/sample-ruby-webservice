require_relative '../../test_helper'
require_relative '../../../app/example'
require 'example/client'
require 'rack/test'
require 'webmock/test_unit'

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
      stub_request(:any, /example.com/).to_rack(AssembledApplication)
    end
    
    should 'provide access to accounts by number' do
      account_params = {name: 'My Account'}

      gateway = Example::Client::AccountsGateway.new(base_uri: 'http://www.example.com')
      created_account = gateway.create(account_params)

      retrieved_account = gateway.find_by_number(created_account.number)
      assert(created_account.number)            
      assert_equal(retrieved_account, created_account) 
      assert_equal('My Account', created_account.name)            
    end
  end  
end
