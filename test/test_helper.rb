lib_path = File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH << lib_path

require 'bundler/setup'
Bundler.require(:test)

require 'test/unit'
require 'shoulda-context'
require 'factory_girl'

FactoryGirl.find_definitions

