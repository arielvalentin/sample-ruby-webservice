require_relative '../../test_helper'
require 'example'

FactoryGirl.define do
  factory :account do
    initialize_with{new(name: name, number: number)}
    name 'Fake account'
    number '8675309'
  end
end

class Example::AccountsServiceTest < Test::Unit::TestCase
  context 'Retrieving existing accounts' do

    should 'provide access to accounts by number' do
      account = build(:account) #, number: '8675309')

      repository = flexmock(:on, Example::AccountsRepository) do |mock|
        mock.should_receive(:find).with(Example::FindByAccountNumberSpecification.new(account.number)).and_return([account])
      end
 
      service = Example::AccountsService.new(repository)
      assert_equal(account, service.find_by_account_number('8675309'))
    end
  end
end
