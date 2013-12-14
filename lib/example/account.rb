class Account
  include Equalizer.new(:name, :number)
  
  attr_reader :number
  attr_reader :name
  
  def initialize(args)
    @number = args[:number]
    @name = args[:name]
  end
end
