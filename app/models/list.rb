class List < ApplicationRecord
  include RankedModel
  belongs_to :board
  ranks :row_order, with_same: :board_id
  has_many :cards, dependent: :destroy
end
