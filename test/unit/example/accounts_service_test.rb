require_relative '../../test_helper'
require 'example'

class Example::AccountsServiceTest < Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods
  include FlexMock::TestCase

  context 'Retrieving existing accounts' do
    should 'provide access to accounts by number' do
      account = build(:account, number: '8675309')

      repository = flexmock(:on, Example::AccountsRepository) do |mock|
        mock.should_receive(:find).with(Example::FindByAccountNumberSpecification.new(account.number)).and_return([account])
      end
 
      service = Example::AccountsService.new(repository)
      assert_equal(account, service.find_by_account_number(account.number))
    end

    should 'represent missing accounts as a nil value' do
      number = '8675309'
      repository = flexmock(:on, Example::AccountsRepository) do |mock|
        mock.should_receive(:find).with(Example::FindByAccountNumberSpecification.new(number)).and_return([])
      end
 
      service = Example::AccountsService.new(repository)
      refute(service.find_by_account_number(number))
    end
  end
end
