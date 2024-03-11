# frozen_string_literal: true

class AddColorToCard < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :color, :string
  end
end
