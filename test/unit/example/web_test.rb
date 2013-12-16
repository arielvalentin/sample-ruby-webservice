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

  should 'provide respond with error when account is missing' do
    number = '987654321'
    service = flexmock(:on, Example::AccountsService) do |mock|
      mock.should_receive(:find_by_account_number).with(number).and_return(nil)
    end

    get "/#{number}", {}, {Example::ContainerKey => {accounts_service: service}}
    refute(last_response.ok?)
    response = JSON.parse(last_response.body, symbolize_names: true)

    assert_equal({message: 'Not Found'}, response)
  end  

  should 'provide access to accounts by number' do
    account = build(:account, number: '75637')
    service = flexmock(:on, Example::AccountsService) do |mock|
      mock.should_receive(:find_by_account_number).with(account.number).and_return(account)
    end

    get "/#{account.number}", {}, {Example::ContainerKey => {accounts_service: service}}
    assert(last_response.ok?)
    actual_account = Example::Account.new(JSON.parse(last_response.body, symbolize_names: true))

    assert_equal(account, actual_account)
  end
  
  
end
