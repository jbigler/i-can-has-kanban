class AddRowOrderToList < ActiveRecord::Migration[7.1]
  def change
    add_column :lists, :row_order, :integer
  end
end
