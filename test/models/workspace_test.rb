# frozen_string_literal: true

require "test_helper"

class WorkspaceTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:memberships)
    should have_many(:users).through(:memberships)
    should have_many(:boards)
  end

  test "should access the owning User through owner method" do
    user = create(:user_with_3_workspaces)
    workspace = user.workspaces.first

    assert_equal user, workspace.owner
  end
end
