# -*- encoding: utf-8 -*-
require File.expand_path('../lib/r2do/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["cgiacomi"]
  gem.email         = ["christiangiacomi@gmail.com"]
  gem.description   = %q{A simple todo gem}
  gem.summary       = %q{A simple todo gem}
  gem.homepage      = ""

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "yard"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "redcarpet"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "r2do"
  gem.require_paths = ["lib"]
  gem.version       = R2do::VERSION
end