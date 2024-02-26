# frozen_string_literal: true

require "application_system_test_case"

class CardsTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_as(create(:user_with_3_workspaces))
    @workspace = @user.workspaces.first
    @board = @workspace.boards.create(name: "Test Board")
    @list1 = @board.lists.create(title: "First List")
    @card1 = @list1.cards.create(title: "First Card")
  end

  test "should show card on board" do
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

  test "should drag card in list" do
    @card2 = @list1.cards.create(title: "Second Card")
    assert @card1.row_order < @card2.row_order

    visit board_url(@board)
    handle = find("#card_#{@card1.id}")
    targetRow = find("#card_#{@card2.id}")

    handle.drag_to(targetRow)
    @card1.reload
    @card2.reload

    assert @card1.row_order > @card2.row_order
  end

  test "should drag card between lists" do
    @list2 = @board.lists.create(title: "Second List")
    assert_equal @list1.id, @card1.list_id

    visit board_url(@board)
    handle = find("#card_#{@card1.id}")
    targetRow = find("#list_#{@list2.id}")

    handle.drag_to(targetRow)
    @card1.reload

    assert_equal @list2.id, @card1.list_id
  end
end
