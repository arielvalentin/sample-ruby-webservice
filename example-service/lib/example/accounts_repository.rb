require 'set'
module Example
  class AccountsRepository
    def initialize
      @accounts = Set[Account.new(number: '12345', name: 'My First Account'), Account.new(number: '54321', name: 'Another Account')]
    end
    
    def find(specification)
      accounts.select{ |account| specification.satisfied_by?(account) }
    end

    def save(*accounts_to_save)
      accounts.merge(accounts_to_save)
    end
    private 
    attr_accessor :accounts    
  end
end
