# frozen_string_literal: true

# Card class
class Card < ApplicationRecord
  include RankedModel

  belongs_to :list, touch: true
  ranks :row_order, with_same: :list_id

  scope :sorted, -> { order(row_order: :asc) }

  normalizes :color, with: -> { _1.downcase.gsub(/[[:space:]]/, "") }

  def color_with_default
    if !self.color || self.color == "none"
      "gray"
    else
      self.color
    end
  end
end
