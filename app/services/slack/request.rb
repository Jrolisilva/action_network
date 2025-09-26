# frozen_string_literal: true

require "httparty"
require "json"

module Slack
  class Request
    SLACK_URL = ENV.fetch("SLACK_URL", "https://slack.com/api/").freeze

    def initialize(channel_id: ENV["SLACK_CHANNEL_ID"], token: ENV["SLACK_BOT_TOKEN"])
      @channel_id = channel_id
      @token = token
    end

    def self.call(**kwargs)
      new(**kwargs).call
    end

    def call
      return [] unless channel_id.present? && token.present?

      response = HTTParty.get(
        "#{SLACK_URL}conversations.history",
        query: { channel: channel_id },
        headers: headers
      )

      body = JSON.parse(response.body)
      raise Slack::Error, body["error"] if body["ok"] == false

      Array(body["messages"])
    rescue StandardError => e
      Rails.logger.error("Slack API error: #{e.message}")
      []
    end

    private

    attr_reader :channel_id, :token

    def headers
      {
        "Authorization" => "Bearer #{token}",
        "Content-Type" => "application/json"
      }
    end
  end

  class Error < StandardError; end
end
