# frozen_string_literal: true

require "test_helper"

class WorkspaceTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:memberships).dependent(:delete_all)
    should have_many(:users).through(:memberships)
    should have_many(:boards).dependent(:destroy)
    should have_many(:invitations).dependent(:destroy)
  end

  test "should access the owning User through owner method" do
    user = create(:user_with_workspace)
    workspace = user.workspaces.first

    assert_equal user, workspace.owner
  end

  test "should delete all memberships when destroyed" do
    user1 = create(:user_with_workspace)
    user2 = create(:user)
    workspace = user1.workspaces.first
    Membership.create(user: user2, workspace:, role: Membership.roles[:editor])

    assert_difference "Membership.count", -2 do
      workspace.destroy
    end
  end
end
