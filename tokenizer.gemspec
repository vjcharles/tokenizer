$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tokenizer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tokenizer"
  s.version     = Tokenizer::VERSION
  s.authors     = ["vjcharles"]
  s.email       = ["vjcharles [at] gmail [dot] com"]
  s.homepage    = "https://github.com/vjcharles/tokenizer"
  s.summary     = "Generate one-time use authenticated links to arbitrary rails resources."
  s.description = "Used in mailer to give users single use updates. used with rails 3.1.0.-4.1.1 and MRI ruby 1.9.4, 2.1.0."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1.0"
  s.add_development_dependency "sqlite3"
end
