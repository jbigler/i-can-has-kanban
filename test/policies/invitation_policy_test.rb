# frozen_string_literal: true

require "test_helper"

class InvitationPolicyTest < ActiveSupport::TestCase
  setup do
    @owner = create(:user_with_workspace)
    @workspace = @owner.workspaces.first
  end

  context "owner" do
    setup do
      @invitation = @workspace.invitations.create(email: "hLZQ2@example.com", role: "viewer", invited_by: @owner)
    end

    should "have these permissions" do
      assert_permit @owner, @invitation, :new
      assert_permit @owner, @invitation, :create
    end
  end

  context "admin" do
    setup do
      @admin = create(:user)
      Membership.create(user: @admin, workspace: @owner.workspaces.first, role: Membership.roles[:admin])
      @invitation = @workspace.invitations.create(email: "hLZQ2@example.com", role: "viewer", invited_by: @admin)
    end

    should "have these permissions" do
      assert_permit @admin, @invitation, :new
      assert_permit @admin, @invitation, :create
    end
  end

  context "editor" do
    setup do
      @editor = create(:user)
      Membership.create(user: @editor, workspace: @owner.workspaces.first, role: Membership.roles[:editor])
      @invitation = @workspace.invitations.create(email: "hLZQ2@example.com", role: "viewer", invited_by: @editor)
    end

    should "have these permissions" do
      refute_permit @editor, @invitation, :new
      refute_permit @editor, @invitation, :create
    end
  end

  context "viewer" do
    setup do
      @viewer = create(:user)
      Membership.create(user: @viewer, workspace: @owner.workspaces.first, role: Membership.roles[:viewer])
      @invitation = @workspace.invitations.create(email: "hLZQ2@example.com", role: "viewer", invited_by: @viewer)
    end

    should "have these permissions" do
      refute_permit @viewer, @invitation, :new
      refute_permit @viewer, @invitation, :create
    end
  end
end
