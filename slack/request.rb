# slack/request.rb
require 'httparty'
require 'json'
require 'dotenv/load'

module Slack
  class Request
    SLACK_URL = ENV['SLACK_URL'] || 'https://slack.com/api/'
    SLACK_CHANNEL_ID = ENV['SLACK_CHANNEL_ID']
    SLACK_BOT_TOKEN = ENV['SLACK_BOT_TOKEN']

    def self.call
      response = HTTParty.get(
        "#{SLACK_URL}conversations.history?channel=#{SLACK_CHANNEL_ID}",
        headers: headers
      )
      puts "Response: #{response.body}"
      JSON.parse(response.body)['messages'] || []
    rescue => e
      puts "Slack API error: #{e.message}"
      []
    end

    private

    def self.headers
      {
        'Authorization' => "Bearer #{SLACK_BOT_TOKEN}",
        'Content-Type' => 'application/json'
      }
    end
  end
end
