# frozen_string_literal: true

require "test_helper"

class InvitationPolicyTest < ActiveSupport::TestCase
  setup do
    @owner = create(:user_with_workspace)
    @workspace = @owner.workspaces.first
    @member = create(:user)
  end

  context "owner" do
    should "have these permissions" do
      invitation = @workspace.invitations.new(email: @member.email, invited_by: @owner, role: Invitation.roles[:editor])
      assert_permit @owner, invitation, :new
      assert_permit @owner, invitation, :create
    end

    should "not be able to invite self" do
      personal_invitation = @workspace.invitations.new(invited_by: @owner, role: Invitation.roles[:owner])
      refute_permit @owner, personal_invitation, :new
      refute_permit @owner, personal_invitation, :create
    end
  end

  context "admin" do
    setup do
      @admin = create(:user)
      Membership.create(user: @admin, workspace: @workspace, role: Membership.roles[:admin])
    end

    should "have these permissions" do
      invitation = @workspace.invitations.new(invited_by: @admin, role: Invitation.roles[:editor])
      assert_permit @admin, invitation, :new
      assert_permit @admin, invitation, :create
    end

    should "not be able to invite self" do
      personal_invitation = @workspace.invitations.new(email: @admin.email, invited_by: @admin, role: Invitation.roles[:admin])
      refute_permit @admin, personal_invitation, :new
      refute_permit @admin, personal_invitation, :create
    end

    should "not be able to invite the owner" do
      owner_invitation = @workspace.invitations.new(email: @owner.email, invited_by: @admin, role: Invitation.roles[:admin])
      refute_permit @admin, owner_invitation, :new
      refute_permit @admin, owner_invitation, :create
    end
  end

  context "editor" do
    setup do
      @editor = create(:user)
      Membership.create(user: @editor, workspace: @workspace, role: Membership.roles[:editor])
    end

    should "not have these permissions" do
      invitation = @workspace.invitations.new(email: @editor.email, invited_by: @editor, role: Invitation.roles[:viewer])
      refute_permit @editor, invitation, :new
      refute_permit @editor, invitation, :create
    end
  end

  context "viewer" do
    setup do
      @viewer = create(:user)
      Membership.create(user: @viewer, workspace: @workspace, role: Membership.roles[:viewer])
    end

    should "not have these permissions" do
      invitation = @workspace.invitations.new(invited_by: @viewer, role: Invitation.roles[:viewer])
      refute_permit @viewer, invitation, :new
      refute_permit @viewer, invitation, :create
    end
  end
end
