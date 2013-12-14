require 'sinatra'

module Example
  class Web < Sinatra::Base
    get '/' do
      'Welcome to the accounts service'
    end
    
    get '/:account_number' do
      if account = accounts_service.find_by_account_number(params[:account_number])
        "Account Details Number: #{account.number} Name: #{account.name}"
      else 
        halt 404
      end
    end

    def accounts_service
      container = env[Example::ContainerKey]
      container[:accounts_service]
    end
  end
end
