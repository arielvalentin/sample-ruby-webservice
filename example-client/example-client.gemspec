# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'example/client/version'

Gem::Specification.new do |spec|
  spec.name          = "example-client"
  spec.version       = Example::Client::VERSION
  spec.authors       = ["arielvalentin"]
  spec.email         = ["ariel@arielvalentin.com"]
  spec.description   = %q{This is a sample client}
  spec.summary       = %q{I already said this is a sample client}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency 'equalizer'  
  spec.add_dependency 'addressable'  
  spec.add_dependency 'httpclient'
end
