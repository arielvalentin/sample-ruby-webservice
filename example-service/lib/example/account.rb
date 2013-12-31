# encoding: UTF-8

module Example
  # Domain model that represets an account
  # I suck at writing comments
  class Account
    include Equalizer.new(:name, :number)

    attr_reader :number
    attr_reader :name

    def initialize(args)
      @number = args[:number]
      @name = args[:name]
    end
  end
end
