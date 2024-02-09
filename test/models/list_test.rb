# frozen_string_literal: true

require "test_helper"

class ListTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:board)
    should have_many(:cards)
  end
end
