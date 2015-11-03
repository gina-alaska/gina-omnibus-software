# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'gina-omnibus-software'

Gem::Specification.new do |s|
  s.name        = "gina-omnibus-software"
  s.version     = GinaOmnibusSoftware::VERSION
  s.authors     = ['Geographic Information Network of Alaska']
  s.email       = ['support+dev@gina.alaska.edu']
  s.homepage    = "http://github.com/gina-alaska/gina-omnibus-software"
  s.summary     = %q{Open Source software for use with Omnibus}
  s.description = %q{Open Source software build descriptions for use with Omnibus}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
