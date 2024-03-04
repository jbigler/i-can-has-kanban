# frozen_string_literal: true

require "application_system_test_case"

class MembersTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_as create(:user_with_workspace)
    @workspace = @user.workspaces.first
    @member = create(:user)
  end

  test "visiting the index" do
    visit workspace_members_url @workspace

    assert_selector "h2", text: "Workspace Members"
  end

  test "should be able to invite a new member" do
    visit workspace_members_url @workspace
    click_on "Invite new member"

    fill_in "Email", with: @member.email
    click_on "Send invitation"

    assert_text "Invitation was successfully sent"
    click_on "Manage Members"
    assert_text @member.email
  end

  test "should be able to change member role" do
    Membership.create!(workspace: @workspace, user: @member, role: "viewer")
    visit workspace_members_url @workspace
    assert_text "Viewer"
    click_on "Edit", match: :first

    select "Editor", from: "Role"
    click_on "Update"

    assert_text "Member was successfully updated"
    assert_text "Editor"
  end

  test "should remove member" do
    Membership.create!(workspace: @workspace, user: @member, role: "viewer")
    visit workspace_members_url(@workspace)

    assert_text @member.email

    accept_alert do
      click_on "Remove", match: :first
    end

    refute_text @member.email
    assert_text "Member was successfully removed"
  end
end
