# frozen_string_literal: true

# Membership class
class Membership < ApplicationRecord
  include RoleEnum

  after_destroy :destroy_owned_workspaces

  # Setting inverse_of allows the associations to be built
  belongs_to :user, inverse_of: :memberships
  belongs_to :workspace, inverse_of: :memberships

  validates :user_id, uniqueness: { scope: :workspace_id }

  def destroy_owned_workspaces
    workspace.destroy if owner?
  end
end
