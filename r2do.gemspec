# -*- encoding: utf-8 -*-
require File.expand_path('../lib/r2do/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["cgiacomi"]
  gem.email         = ["christiangiacomi@gmail.com"]
  gem.summary       = %q{r2do is a simple todo gem for the CLI}
  gem.description   = %q{r2do is a simple todo gem which allows you to create Tasks and group them by Category. r2do is meant for the CLI. }
  gem.homepage      = "https://github.com/cgiacomi/r2do"

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
  gem.license       = "Apache v2"
  gem.post_install_message = "Thanks for installing r2do."
end