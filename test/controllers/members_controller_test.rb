# frozen_string_literal: true

require "test_helper"

class MembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as create(:user_with_workspace)
    @workspace = @user.workspaces.first
    @member = create(:user)
  end

  test "should get index" do
    get workspace_members_url @workspace
    assert_response :success
  end

  test "should get show" do
    membership = Membership.create(user: @member, workspace: @workspace, role: Membership.roles[:editor])
    get workspace_member_url @workspace, membership
    assert_response :success
  end

  test "should get new" do
    get new_workspace_member_url @workspace
    assert_response :success
  end

  test "should create Invitation" do
    assert_difference("Invitation.count") do
      post workspace_members_url(@workspace), params: { invitation: { email: @member.email, role: "editor" } }
    end

    assert_redirected_to workspace_url(@workspace)
  end

  test "should get edit" do
    membership = Membership.create(user: @member, workspace: @workspace, role: Membership.roles[:editor])
    get edit_workspace_member_url @workspace, membership
    assert_response :success
  end

  test "should update membership" do
    membership = Membership.create(user: @member, workspace: @workspace, role: Membership.roles[:editor])
    patch workspace_member_url(@workspace, membership),
          params: { membership: { role: "viewer" } }

    membership.reload
    assert_equal "viewer", membership.role
    assert_redirected_to workspace_member_url(@workspace, membership)
  end

  test "should destroy membership" do
    membership = Membership.create(user: @member, workspace: @workspace, role: Membership.roles[:editor])
    assert_difference("Membership.count", -1) do
      delete workspace_member_url(@workspace, membership)
    end

    assert_redirected_to workspace_url(@workspace)
  end
end
