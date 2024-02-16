require "application_system_test_case"

class CardsTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_as(create(:user_with_workspaces))
    @workspace = @user.workspaces.first
    @board = @workspace.boards.create(name: "Test Board")
    @list = @board.lists.create(title: "First List")
    @card = @list.cards.create(title: "First Card")
  end

  test "visiting the index" do
    visit board_url(@board)

    assert_selector "a", text: "First Card"
  end

  test "should create card" do
    visit board_url(@board)
    click_on "Add Card"

    fill_in "Title", with: "Second Card"
    fill_in "Description", with: "This is my second card"
    click_on "Save"

    assert_selector "a", text: "Second Card"
  end

  test "should update Card" do
    visit board_url(@board)
    click_on "First Card", match: :first

    fill_in "Title", with: "Replacement Card"
    fill_in "Description", with: "Replacement Text"
    click_on "Save"

    assert_selector "a", text: "Replacement Card"
  end

  test "should destroy Card" do
    visit board_url(@board)
    click_on "First Card", match: :first

    accept_alert do
      click_on "Delete", match: :first
    end

    refute_text "First Card"
  end
end
