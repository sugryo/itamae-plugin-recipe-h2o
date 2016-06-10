# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/recipe/h2o/version'

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-recipe-h2o"
  spec.version       = Itamae::Plugin::Recipe::H2o::VERSION
  spec.authors       = ["Ryo Sugimoto"]
  spec.email         = ["sugryo1109@gmail.com"]

  spec.summary       = %q{Itamae plugin to install h2o}
  spec.description   = %q{Itamae plugin to install h2o}
  spec.homepage      = "https://github.com/sugryo/itamae-plugin-recipe-h2o"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "itamae", "~> 1.2"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
