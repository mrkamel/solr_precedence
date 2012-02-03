
$:.push File.expand_path("../lib", __FILE__)
require "solr_precedence/version"

Gem::Specification.new do |s|
  s.name        = "solr_precedence"
  s.version     = SolrPrecedence::VERSION
  s.authors     = ["Benjamin Vetter"]
  s.email       = ["vetter@flakks.com"]
  s.homepage    = ""
  s.summary     = %q{Fixing Solr operator precedence}
  s.description = %q{Fixes Solr's OR operator precedence by using groups}

  s.rubyforge_project = "solr_precedence"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
end

