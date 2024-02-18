# frozen_string_literal: true

require "test_helper"

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as create(:user_with_workspace)
    @workspace = @user.workspaces.first
    @board = @workspace.boards.create(name: "Test board")
    @list = @board.lists.create(title: "First list")
    @card = @list.cards.create(title: "First card")
  end

  test "should get new" do
    get new_list_card_url(@list)

    assert_response :success
  end

  test "should create card" do
    assert_difference("Card.count") do
      post list_cards_url(@list),
           params: { card: { description: @card.description, row_order: @card.row_order,
                             title: @card.title } }
    end

    assert_redirected_to card_url(Card.last)
  end

  test "should show card" do
    get card_url(@card)

    assert_response :success
  end

  test "should get edit" do
    get edit_card_url(@card)

    assert_response :success
  end

  test "should update card" do
    patch card_url(@card),
          params: { card: { description: @card.description, row_order: @card.row_order,
                            title: @card.title } }

    assert_redirected_to card_url(@card)
  end

  test "should destroy card" do
    assert_difference("Card.count", -1) do
      delete card_url(@card)
    end

    assert_redirected_to list_cards_url(@list)
  end
end
