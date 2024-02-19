# frozen_string_literal: true

require "test_helper"

class WorkspacePolicyTest < ActiveSupport::TestCase
  context "owner" do
    setup do
      @owner = create(:user_with_workspace)
      @workspace = @owner.workspaces.first
    end

    should "have these permissions" do
      assert_permit @owner, :workspace, :index
      assert_permit @owner, @workspace, :show
      assert_permit @owner, @workspace, :new
      assert_permit @owner, @workspace, :create
      assert_permit @owner, @workspace, :edit
      assert_permit @owner, @workspace, :update
      assert_permit @owner, @workspace, :destroy
    end
  end

  context "admin" do
    setup do
      @owner = create(:user_with_workspace)
      @admin = create(:user)
      @workspace = @owner.workspaces.first
      Membership.create(user: @admin, workspace: @workspace, role: Membership.roles[:admin])
    end

    should "have these permissions" do
      assert_permit @admin, :workspace, :index
      assert_permit @admin, @workspace, :show
      assert_permit @admin, @workspace, :new
      assert_permit @admin, @workspace, :create
      assert_permit @admin, @workspace, :edit
      assert_permit @admin, @workspace, :update
      refute_permit @admin, @workspace, :destroy
    end
  end

  context "editor" do
    setup do
      @owner = create(:user_with_workspace)
      @editor = create(:user)
      @workspace = @owner.workspaces.first
      Membership.create(user: @editor, workspace: @workspace, role: Membership.roles[:editor])
    end

    should "have these permissions" do
      assert_permit @editor, :workspace, :index
      assert_permit @editor, @workspace, :show
      assert_permit @editor, @workspace, :new
      assert_permit @editor, @workspace, :create
      assert_permit @editor, @workspace, :edit
      assert_permit @editor, @workspace, :update
      refute_permit @editor, @workspace, :destroy
    end
  end

  context "viewer" do
    setup do
      @owner = create(:user_with_workspace)
      @viewer = create(:user)
      @workspace = @owner.workspaces.first
      Membership.create(user: @viewer, workspace: @workspace, role: Membership.roles[:viewer])
    end

    should "have these permissions" do
      assert_permit @viewer, :workspace, :index
      assert_permit @viewer, @workspace, :show
      assert_permit @viewer, @workspace, :new
      assert_permit @viewer, @workspace, :create
      refute_permit @viewer, @workspace, :edit
      refute_permit @viewer, @workspace, :update
      refute_permit @viewer, @workspace, :destroy
    end
  end
end
