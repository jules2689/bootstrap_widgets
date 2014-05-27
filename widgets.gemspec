# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)

require "widgets/version"

Gem::Specification.new do |s|
  s.name          = "widgets"
  s.version       = Widgets::VERSION
  s.authors       = ["Julian Nadeau"]
  s.email         = ["julian@jnadeau.ca"]
  s.summary       = "A simplistic way of rendering dashboard widgets with Bootstrap"
  s.description   = "Add text and graph widgets for a dashboard, rendered with Bootstrap"
  s.homepage      = ""
  s.license       = "MIT"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.4"
  s.add_dependency "jquery-rails"
  s.add_dependency "chart-js-rails"
  s.add_dependency "sass-rails", "~> 4.0.0"
  s.add_dependency "bootstrap-sass", "~> 3.1.1"
end
