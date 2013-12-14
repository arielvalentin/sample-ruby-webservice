require 'bundler'
require 'bundler/setup'
Bundler.require(:default)

require 'rack'
require_relative 'lib/example'
require_relative 'app/example'

use Example::DependencyInjectionMiddleware, Example::Container.new
run Example::Web