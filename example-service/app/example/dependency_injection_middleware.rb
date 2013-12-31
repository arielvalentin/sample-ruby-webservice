# encoding: UTF-8

module Example
  # Thin class that adds Depenendency Injection Module to the request
  # environment (or is it a service locator, I don't know)
  class DependencyInjectionMiddleware
    attr_reader :container
    attr_reader :app

    def initialize(app, container)
      @app = app
      @container = container
    end

    def call(env)
      env[Example::CONTAINER_KEY] = @container
      @app.call(env)
    end
  end
end
