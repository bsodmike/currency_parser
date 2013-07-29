$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "currency_parser/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "currency_parser"
  s.version     = CurrencyParser::VERSION
  s.authors     = ["Michael de Silva"]
  s.email       = ["michael@mwdesilva.com"]
  s.homepage    = "http://mwdesilva.com"
  s.summary     = "Parse strings formatted as currencies"
  s.description = s.summary

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "mocha"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "pry"
  s.add_development_dependency "yard"
end
