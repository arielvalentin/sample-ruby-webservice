# encoding: UTF-8
require 'json'
require 'sinatra'
require 'sinatra/json'
require_relative '../../lib/example'

module Example
  # Enables my application as a webservice
  class Web < Sinatra::Base
    helpers Sinatra::JSON
    NOT_FOUND = { message: 'Not Found' }

    get '/:account_number' do
      account = query_service.find_by_account_number(params[:account_number])
      if account
        [200, json(name: account.name, number: account.number)]
      else
        halt(404, json(NOT_FOUND))
      end
    end

    post '/' do
      account_params = JSON.parse(request.body.read, symbolize_names: true)
      command = Example::CreateAccountCommand.new(account_params)
      account = create_account_handler.call(command)
      [201, json(name: account.name, number: account.number)]
    end

    private

    def create_account_handler
      container = env[Example::CONTAINER_KEY]
      container[:create_account_handler]
    end

    def query_service
      container = env[Example::CONTAINER_KEY]
      container[:accounts_query_service]
    end
  end
end
