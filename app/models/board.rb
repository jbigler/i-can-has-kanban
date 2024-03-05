# frozen_string_literal: true

# Board class
class Board < ApplicationRecord
  belongs_to :workspace
  has_many :lists, dependent: :destroy

  broadcasts_refreshes
end
