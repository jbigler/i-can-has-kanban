class CreateBoards < ActiveRecord::Migration[7.1]
  def change
    create_table :boards do |t|
      t.belongs_to :workspace, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
