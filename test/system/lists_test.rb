# frozen_string_literal: true

require "application_system_test_case"

class ListsTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_as(create(:user_with_workspace))
    @workspace = @user.workspaces.first
    @board = @workspace.boards.create(name: "Test Board")
    @list = @board.lists.create(title: "First List")
  end

  test "visiting boards#show" do
    visit board_url(@board)

    assert_selector "a#label_#{dom_id @list}", text: @list.title
  end

  test "should create list" do
    visit board_url(@board)
    click_on "+ Add New List"

    fill_in "Title", with: "Unique List Name"
    click_on "Save"

    assert_text "Unique List Name"
  end

  test "should update List" do
    visit board_url(@board)
    click_on "First List", match: :first

    fill_in "Title", with: "New Unique Title"
    click_on "Save"

    assert_text "New Unique Title"
  end

  test "should destroy List" do
    visit board_url(@board)
    click_on "First List", match: :first

    accept_alert do
      click_on "Delete", match: :first
    end

    refute_text "First List"
  end
end
