# frozen_string_literal: true

require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "should get index" do
    sign_in_as @user

    get sessions_url

    assert_response :success
  end

  test "should get new" do
    get sign_in_url

    assert_response :success
  end

  test "should sign in" do
    post sign_in_url, params: { email: @user.email, password: "Secret1*3*5*" }

    assert_redirected_to workspaces_url

    get workspaces_url

    assert_response :success
  end

  test "should sign in user@demo.test with any password" do
    post sign_in_url, params: { email: "user@demo.test", password: "12345abcdefg" }

    assert assert_redirected_to workspaces_url
    get workspaces_url
    assert_response :success
  end

  test "should not sign in with wrong credentials" do
    post sign_in_url, params: { email: @user.email, password: "SecretWrong1*3" }

    assert_redirected_to sign_in_url(email_hint: @user.email)
    assert_equal "That email or password is incorrect", flash[:notice]

    get root_url
  end

  test "should go to root after sign out" do
    sign_in_as @user

    delete session_url(@user.sessions.last)

    assert_redirected_to root_url

    get root_url

    assert_response :success
  end
end
