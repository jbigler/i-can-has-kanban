# frozen_string_literal: true

require "test_helper"

class ListPolicyTest < ActiveSupport::TestCase
  setup do
    @owner = create(:user_with_workspace)
    workspace = @owner.workspaces.first
    board = workspace.boards.create(name: "Test board")
    @list = board.lists.create(title: "First list")
  end

  context "owner" do
    should "have these permissions" do
      assert_permit @owner, :list, :index
      assert_permit @owner, @list, :show
      assert_permit @owner, @list, :new
      assert_permit @owner, @list, :create
      assert_permit @owner, @list, :edit
      assert_permit @owner, @list, :update
      assert_permit @owner, @list, :destroy
    end
  end

  context "admin" do
    setup do
      @admin = create(:user)
      Membership.create(user: @admin, workspace: @list.board.workspace, role: Membership.roles[:admin])
    end

    should "have these permissions" do
      assert_permit @admin, :list, :index
      assert_permit @admin, @list, :show
      assert_permit @admin, @list, :new
      assert_permit @admin, @list, :create
      assert_permit @admin, @list, :edit
      assert_permit @admin, @list, :update
      assert_permit @admin, @list, :destroy
    end
  end

  context "editor" do
    setup do
      @editor = create(:user)
      Membership.create(user: @editor, workspace: @list.board.workspace, role: Membership.roles[:editor])
    end

    should "have these permissions" do
      assert_permit @editor, :list, :index
      assert_permit @editor, @list, :show
      assert_permit @editor, @list, :new
      assert_permit @editor, @list, :create
      assert_permit @editor, @list, :edit
      assert_permit @editor, @list, :update
      assert_permit @editor, @list, :destroy
    end
  end

  context "viewer" do
    setup do
      @viewer = create(:user)
      Membership.create(user: @viewer, workspace: @list.board.workspace, role: Membership.roles[:viewer])
    end

    should "have these permissions" do
      assert_permit @viewer, :list, :index
      assert_permit @viewer, @list, :show
      refute_permit @viewer, @list, :new
      refute_permit @viewer, @list, :create
      refute_permit @viewer, @list, :edit
      refute_permit @viewer, @list, :update
      refute_permit @viewer, @list, :destroy
    end
  end
end
