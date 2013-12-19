require 'json'
require 'sinatra'
require 'sinatra/json'
require_relative '../../lib/example'

module Example
  class Web < Sinatra::Base
    helpers Sinatra::JSON
    NotFound = {message: 'Not Found'}

    get '/:account_number' do
      if account = accounts_service.find_by_account_number(params[:account_number])
        json(name: account.name, number: account.number)
      else 
        halt(404, json(NotFound))
      end
    end

    post '/' do
      account_params = JSON.parse(request.body.read, symbolize_names: true)
      command = Example::CreateAccountCommand.new(account_params)
      account = accounts_service.create(command)
      [201, json(name: account.name, number: account.number)]
    end

    private
    def accounts_service
      container = env[Example::ContainerKey]
      container[:accounts_service]
    end
  end
end
