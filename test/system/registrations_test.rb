# frozen_string_literal: true

require "application_system_test_case"

class RegistrationsTest < ApplicationSystemTestCase
  test "signing up" do
    visit sign_up_url

    fill_in "Name", with: "Test User"
    fill_in "Email", with: "lazaronixon@hey.com"
    fill_in "Password", with: "Secret6*4*2*"
    fill_in "Confirm password", with: "Secret6*4*2*"
    find("form").click_on("Sign Up")

    assert_text "Welcome! You have signed up successfully"
  end
end
