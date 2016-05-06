# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'animate-on-scroll/version'

Gem::Specification.new do |spec|
  spec.name          = "animate-on-scroll"
  spec.version       = Animate::On::Scroll::VERSION
  spec.authors       = ["Patrick Steiger"]
  spec.email         = ["psteiger@gmail.com"]

  spec.summary       = %q{JQuery plugin for animating objects as they enter or leave the screen.}
  spec.description   = %q{Animate-on-scroll is designed for simplicity. 'fade' and 'scale3d' animations are currently supported.}
  spec.homepage      = "http://github.com/psteiger/animate-on-scroll"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
