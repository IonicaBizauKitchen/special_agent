# -*- encoding: utf-8 -*-
require 'rake'
$:.push File.expand_path("../lib", __FILE__)
require "special_agent/version"

Gem::Specification.new do |s|
  s.name        = "special_agent"
  s.version     = SpecialAgent::VERSION
  s.authors     = ["Zeke Sikelianos"]
  s.email       = ["zeke@sikelianos.com"]
  s.homepage    = "http://github.com/zeke/special_agent"
  s.summary     = %q{Parse and process User Agents like a secret one}
  s.description = %q{Parse and process User Agents like a secret one}

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "bundler"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
