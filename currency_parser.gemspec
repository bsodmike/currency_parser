# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "currency_parser/version"

Gem::Specification.new do |s|
  s.name        = "currency_parser"
  s.version     = CurrencyParser::VERSION
  s.authors     = ["Michael de Silva"]
  s.email       = ["michael@mwdesilva.com"]
  s.homepage    = "http://mwdesilva.com"
  s.summary     = "Parse strings formatted as currencies"
  s.description = s.summary
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.require_path = "lib"

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency "rails", "~> 3.2.13"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "mocha"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "yard"
end
