# lib/open_ai/request.rb
module OpenAi
  class Request
    attr_reader :text, :api_key, :base_url

    def initialize(text)
      @text = text
      @api_key = ENV['OPENAI_API_KEY']
      @base_url = ENV['OPENAI_URL']
    end

    def self.call(text)
      new(text).call
    end

    def call
      response = HTTParty.post(base_url, headers: headers, body: body)
      JSON.parse(response.body).dig('choices', 0, 'message', 'content')
    rescue => e
      "Erro de tradução: #{e.message}"
    end

    private

    def headers
      {
        'Authorization' => "Bearer #{api_key}",
        'Content-Type' => 'application/json'
      }
    end

    def body
      {
        model: 'gpt-3.5-turbo',
        messages: [
          { role: 'system', content: 'Traduza tudo para português do Brasil.' },
          { role: 'user', content: text }
        ]
      }.to_json
    end
  end
end
