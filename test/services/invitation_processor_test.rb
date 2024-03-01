# frozen_string_literal: true

require "test_helper"

class InvitationProcessorTest < ActiveSupport::TestCase
  test "should process all pending invitations for a user" do
    user1 = create(:user_with_3_workspaces)
    user2 = create(:user)
    user1.workspaces.each do |workspace|
        create(:invitation, workspace: workspace, user: user1, email: user2.email, role: Invitation.roles[:editor])
      end

    assert_difference "Membership.count", 3 do
      InvitationProcessor.process_pending_invitations(user2)
    end
    assert_equal 3, user2.workspaces.others.count
    assert_equal 0, user2.workspaces.mine.count
  end

  test "should process a single invitation user" do
    user1 = create(:user_with_3_workspaces)
    user2 = create(:user)

    user1.workspaces.each do |workspace|
      create(:invitation, workspace: workspace, user: user1, email: user2.email, role: Invitation.roles[:editor])
      assert_difference "Membership.count", 1 do
        InvitationProcessor.process_invitation(Invitation.last)
      end
    end

    assert_equal 3, user2.workspaces.others.count
    assert_equal 0, user2.workspaces.mine.count
  end
end
