# frozen_string_literal: true

require "test_helper"

class BoardTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:workspace)
    should have_many(:lists).dependent(:destroy)
  end
end
