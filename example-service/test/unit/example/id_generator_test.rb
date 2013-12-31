# encoding: UTF-8
require_relative '../../test_helper'
require 'example'

#
class Example::IDGeneratorTest < Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods
  include FlexMock::TestCase
  include FlexMock::ArgumentTypes

  should 'generate account ids based on the name' do
    id_generator = Example::IDGenerator.new

    assert_equal('20f00ee6-08c8-52d8-a3fb-7c43def5c4fa', id_generator.create('something'))
    assert_equal(id_generator.create('something'), id_generator.create('something'))
    refute_equal(id_generator.create('blah'), id_generator.create('something'))
  end

  should 'require name to be present when generating account ids' do
    id_generator = Example::IDGenerator.new

    assert_raise ArgumentError do
      id_generator.create(nil)
    end

    assert_raise ArgumentError do
      id_generator.create(' ')
    end
  end
end
