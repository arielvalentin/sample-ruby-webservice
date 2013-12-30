require_relative '../../test_helper'
require_relative '../../../app/example'
require 'example/client'
require 'rack/test'
require 'webmock/test_unit'

class Example::WebTest < Test::Unit::TestCase
  include FlexMock::TestCase
  include FactoryGirl::Syntax::Methods
  include Rack::Test::Methods
  attr_reader :gateway

  AssembledApplication = Rack::Builder.parse_file(File.expand_path('../../../../config.ru', __FILE__)).first

  def app
    AssembledApplication
  end

  context 'providing access to accounts' do
    setup do
      @gateway = Example::Client::AccountsGateway.new(base_uri: 'http://www.example.com')
      stub_request(:any, /example.com/).to_rack(AssembledApplication)
    end
    
    should 'provide access to accounts by number' do
      created_account = gateway.create(name: 'My Account')      
      retrieved_account = gateway.find_by_number(created_account.number)
      
      assert(created_account.number)            
      assert_equal('My Account', created_account.name)            
      assert_equal(retrieved_account, created_account) 
    end

    should 'represent missing accounts as nil' do
      assert_nil(gateway.find_by_number('000000'))
    end  
  end  
end
