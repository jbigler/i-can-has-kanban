# frozen_string_literal: true

require "test_helper"

class WorkspaceTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:users_workspaces)
    should have_many(:users).through(:users_workspaces)
    should have_many(:boards)
  end
end
