# frozen_string_literal: true

require "json"
require "fileutils"

class TranslationCache
  CACHE_PATH = Rails.root.join("tmp", "cache", "messages.json").freeze

  def initialize
    FileUtils.mkdir_p(CACHE_PATH.dirname)
  end

  def translated_entry_for(message)
    return if message.blank?

    payload = load_cache
    entry = payload[message["ts"]]

    return entry if entry.present?

    translated_text = OpenAi::Request.call(message["text"])

    entry = {
      "ts" => message["ts"],
      "text" => message["text"],
      "translated_text" => translated_text
    }

    payload[message["ts"]] = entry
    persist(payload)

    entry
  end

  def entries
    load_cache.values
  end

  private

  def load_cache
    return {} unless File.exist?(CACHE_PATH)

    JSON.parse(File.read(CACHE_PATH))
  rescue JSON::ParserError
    {}
  end

  def persist(payload)
    File.write(CACHE_PATH, JSON.pretty_generate(payload))
  end
end
