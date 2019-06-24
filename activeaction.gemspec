lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_action/version"

Gem::Specification.new do |spec|
  spec.name          = "active_action"
  spec.version       = ActiveAction::VERSION
  spec.authors       = ["Josh Brody"]
  spec.email         = ["josh@josh.mn"]

  spec.summary       = "A tidy DSL to express batch actions"
  spec.description   = "A tidy DSL to express batch actions"
  spec.homepage      = "https://github.com/joshmn/active_action"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '>= 3.0'
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rails', '>= 5.1.6'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'minitest-rails'
  spec.add_development_dependency 'mocha'
end
