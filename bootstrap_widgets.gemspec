# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)

require "bootstrap_widgets/version"

Gem::Specification.new do |s|
  s.name          = "bootstrap_widgets"
  s.version       = BootstrapWidgets::VERSION
  s.authors       = ["Julian Nadeau"]
  s.email         = ["julian@jnadeau.ca"]
  s.summary       = "A simplistic way of rendering dashboard bootstrap-widgets with Bootstrap"
  s.description   = "Add text and graph bootstrap-widgets for a dashboard, rendered with Bootstrap"
  s.homepage      = "http://github.com/jules2689/bootstrap_widgets"
  s.license       = "MIT"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.4"
  s.add_dependency "jquery-rails", ">= 3.1.0"
  s.add_dependency "sass-rails", ">= 4.0.0"
  s.add_dependency "coffee-rails", ">= 4.0.0"
  s.add_dependency "bootstrap-sass", ">= 3.1.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "pry"
  s.add_development_dependency "pry-remote"
  s.add_development_dependency "pry-nav"
end
