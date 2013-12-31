# encoding: UTF-8
require 'dim'
require 'forwardable'

module Example
  #
  class Container
    extend Forwardable

    def_delegators :application_container, :[], :register

    def initialize
      @application_container = Dim::Container.new
      register_other_stuff
      register_queries_services
    end

    private

    attr_reader :application_container

    def register_other_stuff
      register(:id_generator) do
        IDGenerator.new
      end
    end

    def register_query_services
      register(:accounts_repository) do
        AccountsRepository.new
      end

      register(:accounts_query_service) do |c|
        AccountsQueryService.new(c.accounts_repository)
      end

      register(:create_account_handler) do |c|
        CreateAccountHandler.new(c.accounts_repository, c.id_generator)
      end
    end
  end
end
