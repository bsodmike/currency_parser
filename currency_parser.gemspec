# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "currency_parser/version"

Gem::Specification.new do |spec|
  spec.name        = "currency_parser"
  spec.version     = CurrencyParser::VERSION
  spec.authors     = ["Michael de Silva"]
  spec.email       = ["michael@mwdesilva.com"]
  spec.homepage    = "http://mwdesilva.com"
  spec.summary     = "Parse strings formatted as currencies"
  spec.description = spec.summary
  spec.license     = "MIT"

  spec.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "yard"
end
