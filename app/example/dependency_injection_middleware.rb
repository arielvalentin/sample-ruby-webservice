module Example
  class DependencyInjectionMiddleware
    def initialize(app,container)
      @app = app
      @container = container
    end
    
    def call(env)
      env[Example::ContainerKey] = @container
      @app.call(env)
    end
  end
end
