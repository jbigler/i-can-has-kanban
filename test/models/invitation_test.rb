# frozen_string_literal: true

require "test_helper"

class InvitationTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:workspace)
    should belong_to(:invited_by).class_name("User")
  end

  context "validations" do
    subject { build(:invitation) }
    should validate_presence_of(:email)
    should validate_presence_of(:invited_by)
    should validate_presence_of(:workspace)
    should "role is in the list" do
      validate_inclusion_of(:role).in_array(Invitation.roles.keys)
    end
    should normalize(:email).from(" ME@XYZ.COM\n").to("me@xyz.com")
  end
end
