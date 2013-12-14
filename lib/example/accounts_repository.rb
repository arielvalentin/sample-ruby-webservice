module Example
  class AccountsRepository
    def initialize
      @accounts = [Account.new(number: '12345', name: 'My First Account'), Account.new(number: '54321', name: 'Another Account')]
    end
    
    def find(accounts_specification)
      accounts.select{ |account| accounts_specification.satisfied_by?(account) }
    end

    private 
    attr_reader :accounts
  end
end
