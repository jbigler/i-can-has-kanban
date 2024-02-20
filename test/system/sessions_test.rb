# frozen_string_literal: true

require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
  end

  test "visiting the index" do
    sign_in_as @user
    find_by_id("user-menu-button").click

    click_on "Sessions"

    assert_text "Devices & Sessions"
  end

  test "signing in" do
    visit sign_in_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: "Secret1*3*5*"
    click_on "Login to your account"

    assert_text "Signed in successfully"
  end

  test "signing out" do
    sign_in_as @user
    find_by_id("user-menu-button").click

    click_on "Sign out"

    assert_text "That session has been logged out"
  end
end
