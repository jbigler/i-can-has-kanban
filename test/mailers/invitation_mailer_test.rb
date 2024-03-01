# frozen_string_literal: true

require "test_helper"

class InvitationMailerTest < ActionMailer::TestCase
  setup do
    @user = create(:user_with_workspace)
    @invitation = create(:invitation, invited_by: @user, workspace: @user.workspaces.first)
  end

  test "invitation_email" do
    mail = InvitationMailer.with(invitation: @invitation).invitation_email

    assert_equal "You have been invited to join #{@invitation.workspace.name}", mail.subject
    assert_equal [@invitation.email], mail.to
  end
end
