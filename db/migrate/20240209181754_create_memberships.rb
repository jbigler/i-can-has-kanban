# frozen_string_literal: true

# Create memberships table
class CreateMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :memberships do |t|
      t.belongs_to :user, null: false
      t.belongs_to :workspace, null: false
      t.integer :role, null: false, default: 0

      t.timestamps

      t.index %i[user_id workspace_id], unique: true
      t.index %i[workspace_id user_id]
    end
  end
end
