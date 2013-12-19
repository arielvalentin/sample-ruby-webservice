# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/example/client/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra-example-client"
  spec.version       = Sinatra::Example::Client::VERSION
  spec.authors       = ["arielvalentin"]
  spec.email         = ["ariel@arielvalentin.com"]
  spec.description   = %q{This is an example project I put together for Dan Wellman. I hope you like it}
  spec.summary       = %q{This is just an example client for my webservice}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'httpclient'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
