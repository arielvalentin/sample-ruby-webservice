# encoding: UTF-8
module Example
  #
  class ByAccountNumber
    include Equalizer.new(:account_number)
    attr_reader :account_number

    def initialize(account_number)
      @account_number = account_number
    end

    def satisfied_by?(account)
      account_number == account.number
    end
  end
end
