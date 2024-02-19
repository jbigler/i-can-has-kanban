# frozen_string_literal: true

require "test_helper"

class CardPolicyTest < ActiveSupport::TestCase
  setup do
    @owner = create(:user_with_workspace)
    workspace = @owner.workspaces.first
    board = workspace.boards.create(name: "Test board")
    list = board.lists.create(title: "First list")
    @card = list.cards.create(title: "First card")
  end

  context "owner" do
    should "have these permissions" do
      assert_permit @owner, :board, :index
      assert_permit @owner, @card, :show
      assert_permit @owner, @card, :new
      assert_permit @owner, @card, :create
      assert_permit @owner, @card, :edit
      assert_permit @owner, @card, :update
      assert_permit @owner, @card, :destroy
    end
  end

  context "admin" do
    setup do
      @admin = create(:user)
      Membership.create(user: @admin, workspace: @card.list.board.workspace, role: Membership.roles[:admin])
    end

    should "have these permissions" do
      assert_permit @admin, :card, :index
      assert_permit @admin, @card, :show
      assert_permit @admin, @card, :new
      assert_permit @admin, @card, :create
      assert_permit @admin, @card, :edit
      assert_permit @admin, @card, :update
      assert_permit @admin, @card, :destroy
    end
  end

  context "editor" do
    setup do
      @editor = create(:user)
      Membership.create(user: @editor, workspace: @card.list.board.workspace, role: Membership.roles[:editor])
    end

    should "have these permissions" do
      assert_permit @editor, :card, :index
      assert_permit @editor, @card, :show
      assert_permit @editor, @card, :new
      assert_permit @editor, @card, :create
      assert_permit @editor, @card, :edit
      assert_permit @editor, @card, :update
      assert_permit @editor, @card, :destroy
    end
  end

  context "viewer" do
    setup do
      @viewer = create(:user)
      Membership.create(user: @viewer, workspace: @card.list.board.workspace, role: Membership.roles[:viewer])
    end

    should "have these permissions" do
      assert_permit @viewer, :card, :index
      assert_permit @viewer, @card, :show
      refute_permit @viewer, @card, :new
      refute_permit @viewer, @card, :create
      refute_permit @viewer, @card, :edit
      refute_permit @viewer, @card, :update
      refute_permit @viewer, @card, :destroy
    end
  end
end
