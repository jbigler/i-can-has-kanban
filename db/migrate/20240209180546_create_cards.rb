class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.integer :position
      t.belongs_to :list, null: false, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
