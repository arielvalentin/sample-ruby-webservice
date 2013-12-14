require "dim"

module Example
  class Container
    def initialize
      @application_container = Dim::Container.new
      @application_container.register(:accounts_repository){ Example::AccountsRepository.new }
      @application_container.register(:accounts_service){ |c| Example::AccountsService.new(c.accounts_repository) }
    end
    
    def [](key)
      application_container.send(key)
    end

    private
    attr_reader :application_container
  end
end
