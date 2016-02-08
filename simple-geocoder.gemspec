# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple/geocoder/version'

Gem::Specification.new do |spec|
  spec.name          = "simple-geocoder"
  spec.version       = Simple::Geocoder::VERSION
  spec.authors       = ["andrey.marchenko"]
  spec.email         = ["andrey.marchenko@finreach.de"]
  spec.summary       = %q{Gem for geocoding postal codes data}
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
