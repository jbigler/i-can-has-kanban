# frozen_string_literal: true

require "test_helper"

class HomeontrollerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "should get index" do
    get root_url

    assert_response :success
  end

  test "should redirect to workspaces if logged in" do
    sign_in_as @user

    get root_url

    assert_redirected_to workspaces_url

    get workspaces_url

    assert_response :success
  end
end
