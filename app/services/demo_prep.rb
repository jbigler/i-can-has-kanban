# frozen_string_literal: true

class DemoPrep
  def self.initialize_demo(email)
    user = User.find_by(email: email)
    if !user
      user = FactoryBot.create(:user_with_workspace, email: email)
      populate_workspace(user.workspaces.first)
    elsif user.created_at.to_date != Date.today
      user.workspaces.each do |workspace|
        workspace.destroy
      end
      workspace = user.workspaces.create(name: "Workspace 1")
      populate_workspace(workspace)
    end
    user
  end

  def self.populate_workspace(workspace)
    b = workspace.boards.create(name: "Board 1")
    b.lists.create(title: "List 1")
    b.lists.create(title: "List 2")
  end
end
