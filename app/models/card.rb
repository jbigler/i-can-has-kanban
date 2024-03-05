# frozen_string_literal: true

# Card class
class Card < ApplicationRecord
  include RankedModel

  belongs_to :list, touch: true
  ranks :row_order, with_same: :list_id
end
