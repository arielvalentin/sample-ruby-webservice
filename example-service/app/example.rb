# encoding: UTF-8

# Top level module, which defines constants and load paths.
module Example
  CONTAINER_KEY = 'example.container'
  require_relative 'example/dependency_injection_middleware'
  require_relative 'example/web'
end
