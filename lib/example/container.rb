require "dim"
require_relative 'account'
require_relative 'find_by_account_number_specification'
require_relative 'accounts_repository'
require_relative 'accounts_service'

module Example
  class Container
    attr_reader :application_container
    def initialize
      @application_container = Dim::Container.new
      @application_container.register(:accounts_repository){ Example::AccountsRepository.new }
      @application_container.register(:accounts_service){ |c| Example::AccountsService.new(c.accounts_repository) }
    end
    
    def [](key)
      application_container.send(key)
    end
  end
end
