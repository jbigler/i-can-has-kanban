class CreateJoinTableUserWorkspace < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :workspaces do |t|
      t.index %i[user_id workspace_id]
      t.index %i[workspace_id user_id]
    end
  end
end
