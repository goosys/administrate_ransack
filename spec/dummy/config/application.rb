require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require 'administrate'
require 'administrate_ransack'

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    if (Rails::VERSION::MAJOR == 6 && Rails::VERSION::MINOR == 1) || Rails::VERSION::MAJOR >= 7
      config.active_record.legacy_connection_handling = false
    end
  end
end
