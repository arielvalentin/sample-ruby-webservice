# encoding: UTF-8
require_relative '../../test_helper'
require 'example'
#
class Example::CreateAccountHandlerTest < Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods
  include FlexMock::TestCase
  include FlexMock::ArgumentTypes

  context 'Storing accounts' do
    should 'create a new account' do
      expected = build(:account, name: 'Test Account', number: '832e38b7-b04b-5ed8-97e1-8dcc28e8e4bb')
      
      id_generator = flexmock(:on, Example::IDGenerator) do |mock|
        mock.should_receive(:create).with('Test Account').and_return(expected.number)
      end

      repository = flexmock(:on, Example::AccountsRepository) do |mock|
        mock.should_receive(:save).with(expected)
      end

      service = Example::CreateAccountHandler.new(repository, id_generator)
      command = Example::CreateAccountCommand.new(name: 'Test Account')
      actual = service.call(command)
      assert_equal(expected, actual)
    end
  end
end
