require 'securerandom'

module Example
  class AccountsService
    def initialize(repository)
      @repository = repository
    end

    def find_by_account_number(account_number)
      repository.find(FindByAccountNumberSpecification.new(account_number)).first
    end

    def create(command)
      build_account(command).tap do |account|
        repository.save(account)
      end
    end

    private 
    attr_reader :repository

    def build_account(command)
      Example::Account.new(name: command.name, number: SecureRandom.uuid)
    end
  end
end
