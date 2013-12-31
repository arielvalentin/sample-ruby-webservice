# encoding: UTF-8
module Example
  #
  class CreateAccountCommand
    include Equalizer.new(:name)

    attr_reader :name

    def initialize(args)
      @name = args[:name]
    end
  end
end
