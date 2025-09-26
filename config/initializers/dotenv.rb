# frozen_string_literal: true

if defined?(Dotenv)
  Dotenv.load
  Dotenv.require_keys("OPENAI_API_KEY", "OPENAI_URL", "SLACK_CHANNEL_ID", "SLACK_BOT_TOKEN", "SLACK_URL") if Rails.env.production?
end
