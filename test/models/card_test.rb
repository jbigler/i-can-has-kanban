# frozen_string_literal: true

require "test_helper"

class CardTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:list)
  end
end
