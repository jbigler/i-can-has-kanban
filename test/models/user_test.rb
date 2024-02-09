# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:users_workspaces)
    should have_many(:workspaces).through(:users_workspaces)
    should have_many(:sessions).dependent(:destroy)
  end

  context "validations" do
    subject { build(:user) }
    should validate_presence_of(:email)
    should validate_presence_of(:name)
    should validate_uniqueness_of(:email).ignoring_case_sensitivity
    should normalize(:email).from(" ME@XYZ.COM\n").to("me@xyz.com")
  end
end
