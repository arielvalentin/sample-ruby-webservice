require 'uuidtools'

module Example
  class IDGenerator
    def create(name)
      raise ArgumentError, 'name cannot be blank' if name.to_s.strip.empty?
      UUIDTools::UUID.sha1_create(UUIDTools::UUID_URL_NAMESPACE, name).to_s
    end
  end
end
