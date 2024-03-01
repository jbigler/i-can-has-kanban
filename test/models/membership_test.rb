# frozen_string_literal: true

require "test_helper"

class MembershipTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:user).inverse_of(:memberships)
    should belong_to(:workspace).inverse_of(:memberships)
  end

  context "validations" do
    subject { build(:user_with_workspace).memberships.first }
    should validate_uniqueness_of(:user_id).scoped_to(:workspace_id).ignoring_case_sensitivity
    should "role is in the list" do
      validate_inclusion_of(:role).in_array(Membership.roles.keys)
    end
  end

  test "should only destroy owned workspaces when destroyed" do
    user1 = create(:user_with_3_workspaces)
    user2 = create(:user_with_workspace)

    Membership.create(user: user1, workspace: user2.workspaces.first, role: Membership.roles[:viewer])

    assert_equal(3, user1.workspaces.mine.count)
    assert_difference "Membership.count", -4 do
      assert_difference "Workspace.count", -3 do
        user1.destroy
      end
    end
  end
end
