module OpenAi
  class Request
    attr_reader : text, :api_key, :base_url
    OPENAI_API_KEY = ENV['OPENAI_API_KEY']
    URL = ENV['OPENAI_URL']

    def initialize(text)
      @text = text
      @api_key = OPENAI_API_KEY
      @base_url = 'https://api.openai.com/v1'
    end

    def self.call
      new(ENV['OPENAI_API_KEY']).call
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
        'Authorization' => "Bearer #{OPENAI_API_KEY}",
        'Content-Type' => 'application/json'
      }
    end

    def body
      body = {
        model: 'gpt-3.5-turbo',
        messages: [
          { role: 'system', content: 'Traduza tudo para português do Brasil.' },
          { role: 'user', content: text }
        ]
      }.to_json
    end
  end
end
