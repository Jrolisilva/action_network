# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ActionNetwork
  class Application < Rails::Application
    config.load_defaults 8.0

    config.api_only = true

    config.autoload_paths << Rails.root.join("lib")
    config.eager_load_paths << Rails.root.join("app", "services")

  end
end
