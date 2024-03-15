# frozen_string_literal: true

require "test_helper"

class DemoPrepTest < ActiveSupport::TestCase
  test "initialize demo if no users exist" do
    user = User.find_by(email: "user@demo.test")
    assert_nil user
    user = DemoPrep.initialize_demo("user@demo.test")
    assert user
  end

  test "if user exists and was created today, do nothing" do
    user = create(:user_with_workspace, email: "user@demo.test")
    user.workspaces.create(name: "Workspace 2")
    assert_equal 2, user.workspaces.count
    demo_user = DemoPrep.initialize_demo("user@demo.test")
    assert_equal 2, demo_user.workspaces.count
  end

  test "if user exists and was not created today, create empty workspace" do
    user = create(:user_with_workspace, email: "user@demo.test")
    user.workspaces.create(name: "Workspace 2")
    assert_equal 2, user.workspaces.count
    travel 1.day do
      demo_user = DemoPrep.initialize_demo("user@demo.test")
      assert_equal 1, demo_user.workspaces.count
    end
  end
end
