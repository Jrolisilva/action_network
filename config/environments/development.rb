# frozen_string_literal: true

require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false

  config.consider_all_requests_local = true
  config.server_timing = true

  config.cache_store = :memory_store
  config.public_file_server.enabled = true

  config.active_support.deprecation = :log
  config.active_support.report_deprecations = true

  config.action_controller.raise_on_missing_callback_actions = false

  config.hosts.clear
end
