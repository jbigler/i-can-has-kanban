# frozen_string_literal: true

require "test_helper"

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as(create(:user_with_workspace))
    @workspace = @user.workspaces.first
  end

  test "should get new" do
    get new_workspace_invitation_url(@workspace)
    assert_response :success
  end

  test "should get create" do
    assert_difference("Invitation.count") do
      post workspace_invitation_url(@workspace), params: { invitation: { workspace_id: @workspace.id, email: "a@a.com", role: "viewer" } }
    end

    assert_redirected_to workspace_url(@workspace)
  end
end
