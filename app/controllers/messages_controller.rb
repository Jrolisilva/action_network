# frozen_string_literal: true

class MessagesController < ApplicationController
  def index
    cache = TranslationCache.new
    messages = Array(Slack::Request.call)

    enriched = messages.map do |message|
      translated_entry = translate_if_applicable(cache, message)

      {
        ts: message["ts"],
        user: message["user"],
        text: message["text"],
        subtype: message["subtype"],
        translated_text: translated_entry&.fetch("translated_text", nil)
      }
    end

    render json: { messages: enriched }
  end

  private

  def translate_if_applicable(cache, message)
    return if message["text"].blank?
    return if message["subtype"] == "bot_message"

    cache.translated_entry_for(message)
  end
end
