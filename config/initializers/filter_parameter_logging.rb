# frozen_string_literal: true

Rails.application.config.filter_parameters += %i[
  password
  password_confirmation
  credit_card
  access_token
  authorization
]
