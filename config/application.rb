# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GithubRepoSearchApp
  # Application
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    ## Autoload Paths
    config.autoload_paths << "#{config.root}/app/*/concerns"
    config.autoload_paths << "#{config.root}/app/enum"

    ## Internationalization
    config.i18n.load_path     += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :'pt-BR'

    ## API
    config.api_only = false

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')

      if File.exists?(env_file)
        YAML.safe_load(File.open(env_file)).each do |key, value|
          ENV[key.to_s] = value
        end
      end
    end
  end
end
