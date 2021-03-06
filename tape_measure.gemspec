# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tape_measure/version'

Gem::Specification.new do |spec|

  spec.name          = 'tape_measure'
  spec.version       = TapeMeasure::VERSION
  spec.authors       = ['Sam Congleton']
  spec.email         = ['sam@burningpony.com']
  spec.summary       = %q(Measurements parser and converter.)
  spec.description   = %q(Contains a text parser for converting various measurements into a base unit, as well as doing several mathematical functions with those numbers)
  spec.homepage      = 'https://github.com/burningpony/tape_measure'
  spec.license       = 'GNU v3'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'citrus'
  spec.add_dependency 'ruby-units'
end
