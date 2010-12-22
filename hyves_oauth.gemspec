# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "hyves_oauth/version"

Gem::Specification.new do |s|
  s.name        = "hyves_oauth"
  s.version     = HyvesOauth::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kevin van Dijk"]
  s.email       = ["kevin@madkangaroo.com"]
  s.homepage    = ""
  s.summary     = %q{A Ruby client for the Hyves API using OAuth}
  s.description = %q{A Ruby client for the Hyves API using OAuth}

  s.rubyforge_project = "hyves_oauth"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
