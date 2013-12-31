# encoding: UTF-8
module Example
  #
  class AccountsQueryService
    def initialize(repository)
      @repository = repository
    end

    def find_by_account_number(account_number)
      repository.find(ByAccountNumber.new(account_number)).first
    end

    private

    attr_reader :repository
  end
end
