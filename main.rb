# frozen_string_literal: true
require_relative './slack/request'
require_relative './open_ai/request'
require 'sinatra'
require 'json'
require 'httparty'
require 'dotenv/load'

set :bind, '0.0.0.0'
set :port, 4567

CACHE_FILE = 'cache/messages.json'

FileUtils.mkdir_p('cache')
File.write(CACHE_FILE, '[]') unless File.exist?(CACHE_FILE)

def load_cache
  JSON.parse(File.read(CACHE_FILE))
rescue JSON::ParserError
  []
end

def save_cache(messages)
  File.write(CACHE_FILE, messages.to_json)
end

Thread.new do
  loop do
    sleep 3
    messages = Slack::Request.call
    cached = load_cache
    known_ids = cached.map { |message| message['ts'] }

    new_messages = messages.reject{ |message| known_ids.include?(message['ts']) }

    new_messages.each do |message|
      next if message['subtype'] == 'bot_message'
      translated_message = OpenAi::Request.call(message['text'])

      cached << { ts: message['ts'], text: translated_message }
    end
    save_cache(messages)
  end
end
