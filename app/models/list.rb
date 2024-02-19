# frozen_string_literal: true

class List < ApplicationRecord
  include RankedModel

  belongs_to :board
  has_many :cards, dependent: :destroy

  ranks :row_order, with_same: :board_id
end
