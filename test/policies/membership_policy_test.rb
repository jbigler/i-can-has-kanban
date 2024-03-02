# frozen_string_literal: true

require "test_helper"

class MembershipPolicyTest < ActiveSupport::TestCase
  setup do
    @owner = create(:user_with_workspace)
    @workspace = @owner.workspaces.first
    @member = create(:user)
    @membership = Membership.create(user: @member, workspace: @workspace, role: Membership.roles[:editor])
  end

  context "owner" do
    should "have these permissions" do
      assert_permit @owner, :membership, :index
      assert_permit @owner, @membership, :show
      assert_permit @owner, @membership, :new
      assert_permit @owner, @membership, :create
      assert_permit @owner, @membership, :edit
      assert_permit @owner, @membership, :update
      assert_permit @owner, @membership, :destroy
    end
  end

  context "admin" do
    setup do
      @admin = create(:user)
      Membership.create(user: @admin, workspace: @workspace, role: Membership.roles[:admin])
    end

    should "have these permissions" do
      assert_permit @admin, :membership, :index
      assert_permit @admin, @membership, :show
      assert_permit @admin, @membership, :new
      assert_permit @admin, @membership, :create
      assert_permit @admin, @membership, :edit
      assert_permit @admin, @membership, :update
      assert_permit @admin, @membership, :destroy
    end
  end

  context "editor" do
    setup do
      @editor = create(:user)
      Membership.create(user: @editor, workspace: @workspace, role: Membership.roles[:editor])
    end

    should "have these permissions" do
      assert_permit @editor, :membership, :index
      assert_permit @editor, @membership, :show
      refute_permit @editor, @membership, :new
      refute_permit @editor, @membership, :create
      refute_permit @editor, @membership, :edit
      refute_permit @editor, @membership, :update
      refute_permit @editor, @membership, :destroy
    end
  end

  context "viewer" do
    setup do
      @viewer = create(:user)
      Membership.create(user: @viewer, workspace: @workspace, role: Membership.roles[:viewer])
    end

    should "have these permissions" do
      assert_permit @viewer, :membership, :index
      assert_permit @viewer, @membership, :show
      refute_permit @viewer, @membership, :new
      refute_permit @viewer, @membership, :create
      refute_permit @viewer, @membership, :edit
      refute_permit @viewer, @membership, :update
      refute_permit @viewer, @membership, :destroy
    end
  end
end
