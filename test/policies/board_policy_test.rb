# frozen_string_literal: true

require "test_helper"

class BoardPolicyTest < ActiveSupport::TestCase
  setup do
    @owner = create(:user_with_workspace)
    workspace = @owner.workspaces.first
    @board = workspace.boards.create(name: "Test board")
  end

  context "owner" do
    should "have these permissions" do
      assert_permit @owner, :board, :index
      assert_permit @owner, @board, :show
      assert_permit @owner, @board, :new
      assert_permit @owner, @board, :create
      assert_permit @owner, @board, :edit
      assert_permit @owner, @board, :update
      assert_permit @owner, @board, :destroy
    end
  end

  context "admin" do
    setup do
      @admin = create(:user)
      Membership.create(user: @admin, workspace: @board.workspace, role: Membership.roles[:admin])
    end

    should "have these permissions" do
      assert_permit @admin, :board, :index
      assert_permit @admin, @board, :show
      assert_permit @admin, @board, :new
      assert_permit @admin, @board, :create
      assert_permit @admin, @board, :edit
      assert_permit @admin, @board, :update
      assert_permit @admin, @board, :destroy
    end
  end

  context "editor" do
    setup do
      @editor = create(:user)
      Membership.create(user: @editor, workspace: @board.workspace, role: Membership.roles[:editor])
    end

    should "have these permissions" do
      assert_permit @editor, :board, :index
      assert_permit @editor, @board, :show
      refute_permit @editor, @board, :new
      refute_permit @editor, @board, :create
      assert_permit @editor, @board, :edit
      assert_permit @editor, @board, :update
      refute_permit @editor, @board, :destroy
    end
  end

  context "viewer" do
    setup do
      @viewer = create(:user)
      Membership.create(user: @viewer, workspace: @board.workspace, role: Membership.roles[:viewer])
    end

    should "have these permissions" do
      assert_permit @viewer, :board, :index
      assert_permit @viewer, @board, :show
      refute_permit @viewer, @board, :new
      refute_permit @viewer, @board, :create
      refute_permit @viewer, @board, :edit
      refute_permit @viewer, @board, :update
      refute_permit @viewer, @board, :destroy
    end
  end
end
