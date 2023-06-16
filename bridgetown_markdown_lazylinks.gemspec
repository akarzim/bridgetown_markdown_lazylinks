# frozen_string_literal: true

require_relative "lib/bridgetown_markdown_lazylinks/version"

Gem::Specification.new do |spec|
  spec.name          = "bridgetown_markdown_lazylinks"
  spec.version       = BridgetownMarkdownLazylinks::VERSION
  spec.author        = "François Vantomme"
  spec.email         = "akarzim@pm.me"
  spec.summary       = "Support for lazy markdown reference links"
  spec.homepage      = "https://github.com/akarzim/bridgetown_markdown_lazylinks"
  spec.license       = "GPL-3.0-or-later"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|script|spec|features|frontend)/!) }
  spec.test_files    = spec.files.grep(%r!^test/!)
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_dependency "bridgetown", ">= 1.2.0", "< 2.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", ">= 13.0"
  spec.add_development_dependency "rubocop-bridgetown", "~> 0.3"
end
