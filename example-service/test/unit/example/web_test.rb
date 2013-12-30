require_relative '../../test_helper'
require_relative '../../../app/example'
require 'rack/test'

class Example::WebTest < Test::Unit::TestCase
  include FlexMock::TestCase
  include FactoryGirl::Syntax::Methods
  include Rack::Test::Methods

  def app
    Example::Web
  end

  context 'retrieving accounts' do
    should 'provide respond with error when account is missing' do
      number = '987654321'
      service = flexmock(:on, Example::AccountsQueryService) do |mock|
        mock.should_receive(:find_by_account_number).with(number).and_return(nil)
      end
      
      get "/#{number}", {}, {Example::ContainerKey => {accounts_query_service: service}}
      refute(last_response.ok?)
      response = JSON.parse(last_response.body, symbolize_names: true)
      
      assert_equal({message: 'Not Found'}, response)
    end  
    
    should 'provide access to accounts by number' do
      account = build(:account, number: '75637')
      service = flexmock(:on, Example::AccountsQueryService) do |mock|
        mock.should_receive(:find_by_account_number).with(account.number).and_return(account)
      end
      
      get "/#{account.number}", {}, {Example::ContainerKey => {accounts_query_service: service}}
      assert(last_response.ok?)
      actual_account = Example::Account.new(JSON.parse(last_response.body, symbolize_names: true))
      
      assert_equal(account, actual_account)
    end
  end
  
  context 'creating new accounts' do
    should 'allow creation of new accounts' do
      account = build(:account, name: 'My Account')
      handler = flexmock(:on, Example::CreateAccountHandler) do |mock|
        mock.should_receive(:call).with(Example::CreateAccountCommand.new(name: 'My Account')).and_return(account)
      end
      
      post '/', {name: 'My Account'}.to_json, {Example::ContainerKey => {create_account_handler: handler, 'Content-Type' => 'application/json'}}
      assert_equal(201, last_response.status, last_response.body)
      actual_account = Example::Account.new(JSON.parse(last_response.body, symbolize_names: true))
      
      assert_equal(account, actual_account)
    end
  end  
end
