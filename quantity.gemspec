$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "quantity/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "quantity"
  s.version     = Quantity::VERSION
  s.authors     = ["Clairton Rodrigo Heinzen"]
  s.email       = ["clairton.rodrigo@gmail.com"]
  s.homepage    = "http://github.com.br/clairton"
  s.summary     = "Quantity Pattern"
  s.description = "Quantity Pattern implementation for active record"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 4.1.4'

  s.add_dependency 'enumerize'

  s.add_development_dependency 'sqlite3'

  s.add_development_dependency 'pry-byebug'
end
