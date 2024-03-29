# frozen_string_literal: true

require "application_system_test_case"

class BoardsTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_as(create(:user_with_3_workspaces))
    @workspace = @user.workspaces.first
    @board = @workspace.boards.create(name: "Test Board")
  end

  test "should display boards" do
    visit workspace_boards_url(@workspace)

    assert_selector "h1", text: "Boards"
  end

  test "should display boards on workspace" do
    visit workspace_url(@workspace)

    assert_text "Test Board"
  end

  test "should create board" do
    visit workspace_boards_url(@workspace)
    click_on "Add board"

    fill_in "Name", with: @board.name
    click_on "Create Board"

    assert_text "Board was successfully created"
    click_on "Back"
  end

  test "should create board from workspace" do
    visit workspace_url(@workspace)
    click_on "Add board"

    fill_in "Name", with: "My new board"
    click_on "Create Board"

    assert_text "Board was successfully created"
    assert_text "My new board"
  end

  test "should update board from workspace" do
    visit workspace_url(@workspace)
    within("##{dom_id @board}") do
      click_on "Edit"
    end

    fill_in "Name", with: @board.name
    click_on "Update Board"

    assert_text "Board was successfully updated"
  end

  test "should destroy Board" do
    visit workspace_url(@workspace)
    accept_alert do
      within("##{dom_id @board}") do
        click_on "Delete"
      end
    end

    assert_text "Board was successfully destroyed"
  end
end
