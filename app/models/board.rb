# frozen_string_literal: true

class Board < ApplicationRecord
  belongs_to :workspace
  has_many :lists
end
