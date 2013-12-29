require 'dim'
require 'forwardable'

module Example
  class Container
    extend Forwardable

    def_delegators :application_container, :[], :register

    def initialize
      @application_container = Dim::Container.new
      register(:accounts_repository){ AccountsRepository.new }
      register(:accounts_service){ |c| AccountsService.new(c.accounts_repository) }
      register(:id_generator){ IDGenerator.new }
      register(:create_account_handler){ |c| CreateAccountHandler.new(c.accounts_repository,c.id_generator)  }
    end
        
    private
    attr_reader :application_container
  end
end
