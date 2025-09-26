# frozen_string_literal: true

require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    Slack::Request.stub :call, [] do
      get messages_url
      assert_response :success
      assert_equal({"messages" => []}, JSON.parse(response.body))
    end
  end
end
