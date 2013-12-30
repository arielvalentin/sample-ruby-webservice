$:.unshift File.dirname(__FILE__)
require 'bundler'
require 'bundler/setup'
Bundler.require(:default)

require 'rack'
require 'app/example'

use Example::DependencyInjectionMiddleware, Example::Container.new
run Example::Web
