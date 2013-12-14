lib_path = File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH << lib_path

require 'bundler/setup'
Bundler.require(:test)

require 'test/unit'
require 'flexmock/test_unit'
require 'shoulda-context'
require 'factory_girl'

class Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end

