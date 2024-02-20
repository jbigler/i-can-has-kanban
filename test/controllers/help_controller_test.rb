# frozen_string_literal: true

require "test_helper"

class HelpControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as(create(:user_with_workspace))
  end

  test "should get index" do
    get help_url

    assert_response :success
  end
end
