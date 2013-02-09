# -*- encoding: utf-8 -*-
require File.expand_path( '../lib/opinio/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "opinio-bootstrap"
  s.version     = Opinio::Version::VERSION
  s.platform    = Gem::Platform::RUBY

  s.authors     = [ "Luiz Felipe Garcia Pereira", "Richard Carey" ]
  s.email       = [ "luiz.felipe.gp@gmail.com", "rdcarey@gmail.com" ]

  s.homepage    = "https://github.com/rceee/opinio"

  s.summary     = "A rails 3 engine for comments, with Twitter Bootstrap styling."
  s.description = 'Opinio is an engine used to add comments functionallity to rails 3 applications; this version is adapted to Twitter Bootstrap.'

  s.add_dependency( 'rails', '~> 3' )
  s.add_dependency( 'kaminari' )
  s.add_dependency( 'jquery-rails' )
  s.add_dependency( 'bootstrap-sass', ">= 2.2.2.0" )

  s.files       = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
end
