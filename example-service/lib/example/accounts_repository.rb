# encoding: UTF-8
require 'set'
module Example
  #
  class AccountsRepository
    def initialize
      @accounts = Set[]
    end

    def find(specification)
      accounts.select { |account| specification.satisfied_by?(account) }
    end

    def save(*accounts_to_save)
      accounts.merge(accounts_to_save)
    end

    private

    attr_accessor :accounts
  end
end
