# encoding: utf-8

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require "gemit/version"

Gem::Specification.new do |s|
  s.name        = "gemit"
  s.version     = Gemit::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kristoffer Roupé"]
  s.email       = ["kitofr@gmail.com"]
  s.homepage    = %q{http://github.com/kitofr/gemit}

  s.summary     = %q{A simple gem scaffolder}
  s.description = %q{Scaffolds some things I most of the time want when creating a gem}

  s.rubyforge_project = "gemit"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.required_ruby_version = '>= 1.8.7'
end
