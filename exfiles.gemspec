# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "exfiles/version"

Gem::Specification.new do |spec|
  spec.name          = "exfiles"
  spec.version       = Exfiles::VERSION
  spec.authors       = ["Eduardo Maia"]
  spec.email         = ["eduvimaia@gmail.com"]

  spec.summary       = "Installer for EmaiaX's dotFILES. EXFILES."
  spec.summary       = "Installer for EmaiaX's dotFILES. EXFILES."
  spec.homepage      = "https://github.com/emaiax/exfiles"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "simplecov"
end
