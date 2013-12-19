require_relative '../../test_helper'
require_relative '../../../app/example'
require 'rack/test'
require 'webmock/test_unit'

require 'addressable/uri'
require 'httpclient'
class SinatraExampleClient
  DefaultHeaders = {'Content-Type' => 'application/json'}

  class Account
    include Equalizer.new(:name, :number)
    
    attr_reader :number
    attr_reader :name
  
    def initialize(args)
      @number = args[:number]
      @name = args[:name]
    end
  end

  def initialize(args={})
    @base_uri = args.fetch(:base_uri, 'http://localhost:9292')
    @http_client = HTTPClient.new
  end

  def create_account(account_params)
    response = http_client.post('http://www.example.com/', account_params.to_json, {'Content-Type' => 'application/json'})
    Account.new(JSON.parse(response.body, symbolize_names: true))
  end

  def find_by_account_number(number)
    response = http_client.get("#{base_uri}/#{number}")
    Account.new(JSON.parse(response.body, symbolize_names: true))
  end

  private 
  attr_reader :base_uri, :http_client
end


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

      client = SinatraExampleClient.new(base_uri: 'http://www.example.com')
      created_account = client.create_account(account_params)

      retrieved_account = client.find_by_account_number(created_account.number)
      assert(created_account.number)            
      assert_equal(retrieved_account, created_account) 
      assert_equal('My Account', created_account.name)            
    end
  end  
end
