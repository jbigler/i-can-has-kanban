# frozen_string_literal: true

class CreateInvitations < ActiveRecord::Migration[7.1]
  def change
    create_table :invitations do |t|
      t.string :email, null: false
      t.belongs_to :invited_by, null: false, foreign_key: { to_table: :users }
      t.belongs_to :workspace, null: false, foreign_key: true
      t.integer :role, null: false, default: 3

      t.timestamps
    end
  end
end
