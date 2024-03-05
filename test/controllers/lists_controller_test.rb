# frozen_string_literal: true

require "test_helper"

class ListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as create(:user_with_workspace)
    @workspace = @user.workspaces.first
    @board = @workspace.boards.create(name: "Test board")
    @list = @board.lists.create(title: "First list")
  end

  test "should get new" do
    get new_board_list_url(@board)

    assert_response :success
  end

  test "should create list" do
    assert_difference("List.count") do
      post board_lists_url(@board),
           params: { list: { board_id: @list.board_id, title: @list.title } }
    end

    assert_redirected_to board_url(@board)
  end

  test "should show list" do
    get list_url(@list)

    assert_response :success
  end

  test "should get edit" do
    get edit_list_url(@list)

    assert_response :success
  end

  test "should update list" do
    patch list_url(@list),
          params: { list: { board_id: @list.board_id, title: @list.title } }

    assert_redirected_to board_url(@board)
  end

  test "should destroy list" do
    assert_difference("List.count", -1) do
      delete list_url(@list)
    end

    assert_redirected_to board_url(@board)
  end
end
