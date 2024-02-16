# frozen_string_literal: true

require "test_helper"

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as create(:user_with_workspaces)
    @workspace = @user.workspaces.first
    @board = @workspace.boards.create(name: "Test board")
  end

  test "should get index" do
    get workspace_boards_url(@workspace)

    assert_response :success
  end

  test "should get new" do
    get new_workspace_board_url(@workspace)

    assert_response :success
  end

  test "should create board" do
    assert_difference("Board.count") do
      post workspace_boards_url(@workspace), params: { board: { name: @board.name, workspace_id: @board.workspace_id } }
    end

    assert_redirected_to workspace_url(@workspace)
  end

  test "should show board" do
    get board_url(@board)

    assert_response :success
  end

  test "should get edit" do
    get edit_board_url(@board)

    assert_response :success
  end

  test "should update board" do
    patch board_url(@board),
          params: { board: { name: @board.name, workspace_id: @board.workspace_id } }

    assert_redirected_to board_url(@board)
  end

  test "should destroy board" do
    assert_difference("Board.count", -1) do
      delete board_url(@board)
    end

    assert_redirected_to workspace_url(@workspace)
  end
end
