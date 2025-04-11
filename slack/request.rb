module Slack
  class Request
    SLACK_CHANNEL_ID = ENV['SLACK_CHANNEL_ID']
    SLACK_BOT_TOKEN = ENV['SLACK_BOT_TOKEN']
    SLACK_URL = ENV['SLACK_URL']

    def self.call
      response = HTTParty.post("#{SLACK_URL}conversations.history?channel=#{SLACK_CHANNEL_ID}", headers: headers)
      JSON.parse(response.body)['message'] || []
    end

    def self.headers
      {
        'Authorization' => "Bearer #{SLACK_TOKEN}",
        'Content-Type' => 'application/json'
      }
    end
  end
end
