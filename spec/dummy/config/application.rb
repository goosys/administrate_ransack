require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require 'administrate'
require 'administrate_ransack'
require_relative '../lib/administrate/field/age'

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.active_support.cache_format_version = 7.0

    config.after_initialize do
      AdministrateRansack.add_filter('Administrate::Field::Age', 'field_age')
    end
  end
end
