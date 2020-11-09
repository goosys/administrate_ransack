# frozen_string_literal: true

$:.push File.expand_path('lib', __dir__)

require 'administrate_ransack/version'

Gem::Specification.new do |spec|
  spec.name        = 'administrate_ransack'
  spec.version     = AdministrateRansack::VERSION
  spec.authors     = ['Mattia Roccoberton']
  spec.email       = ['mat@blocknot.es']
  spec.homepage    = 'https://github.com/blocknotes/administrate_ransack'
  spec.summary     = 'Administrate Ransack plugin'
  spec.description = 'A plugin for Administrate to use Ransack for filtering resources'
  spec.license     = 'MIT'

  if spec.respond_to?(:metadata)
    # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_runtime_dependency 'administrate', '~> 0.14.0'
  spec.add_runtime_dependency 'ransack', '~> 1.8.7'

  spec.add_development_dependency 'activestorage', '~> 6.0.3.2'
  spec.add_development_dependency 'capybara', '~> 3.33.0'
  spec.add_development_dependency 'pry', '~> 0.13.1'
  spec.add_development_dependency 'puma', '~> 4.3.5'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4.1'
  spec.add_development_dependency 'rspec-rails', '~> 4.0.1'
  spec.add_development_dependency 'rubocop', '~> 0.90.0'
  spec.add_development_dependency 'selenium-webdriver', '~> 3.142.7'
  spec.add_development_dependency 'sqlite3', '~> 1.4.2'
end
