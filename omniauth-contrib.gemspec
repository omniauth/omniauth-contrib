# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-contrib/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth', '~> 1.0.0.pr2'
  gem.add_dependency 'omniauth-oauth', '~> 1.0.0.pr2'
  gem.add_dependency 'omniauth-oauth2', '~> 1.0.0.pr2'
  gem.add_dependency 'multi_json'

  gem.authors       = ["Michael Bleigh"]
  gem.email         = ["michael@intridea.com"]
  gem.description   = %q{A temporary collection of OmniAuth strategies for 1.0}
  gem.summary       = %q{A temporary collection of OmniAuth strategies for 1.0}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-contrib"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Contrib::VERSION
end
