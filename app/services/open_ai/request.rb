# frozen_string_literal: true

require "httparty"
require "json"

module OpenAi
  class Request
    DEFAULT_SYSTEM_PROMPT = "Traduza tudo para português do Brasil.".freeze

    def initialize(text, api_key: ENV["OPENAI_API_KEY"], base_url: ENV["OPENAI_URL"])
      @text = text
      @api_key = api_key
      @base_url = base_url
    end

    def self.call(text, **kwargs)
      new(text, **kwargs).call
    end

    def call
      return if text.blank? || api_key.blank? || base_url.blank?

      response = HTTParty.post(base_url, headers: headers, body: body)
      parsed = JSON.parse(response.body)
      parsed.dig("choices", 0, "message", "content")
    rescue StandardError => e
      Rails.logger.error("OpenAI API error: #{e.message}")
      nil
    end

    private

    attr_reader :text, :api_key, :base_url

    def headers
      {
        "Authorization" => "Bearer #{api_key}",
        "Content-Type" => "application/json"
      }
    end

    def body
      {
        model: ENV.fetch("OPENAI_MODEL", "gpt-3.5-turbo"),
        messages: [
          { role: "system", content: DEFAULT_SYSTEM_PROMPT },
          { role: "user", content: text }
        ]
      }.to_json
    end
  end
end
