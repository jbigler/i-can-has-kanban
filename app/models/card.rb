class Card < ApplicationRecord
  include RankedModel

  belongs_to :list
  ranks :row_order, with_same: :list_id
end
