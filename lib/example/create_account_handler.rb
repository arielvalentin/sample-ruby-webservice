module Example
  class CreateAccountHandler
    def initialize(repository, id_generator)
      @repository = repository
      @id_generator = id_generator
    end

    def call(command)
      build_account(command).tap do |account|
        repository.save(account)
      end
    end

    private 
    attr_reader :repository
    attr_reader :id_generator

    def build_account(command)
      Example::Account.new(name: command.name, number: id_generator.create(command.name))
    end
  end
end
