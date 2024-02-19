# frozen_string_literal: true

# Workspace Authorization Policy
class WorkspacePolicy < ApplicationPolicy
  def update?
    permitted_roles = Membership.roles.except(:viewer)

    role = @user.memberships.where(workspace_id: record.id).first.role
    permitted_roles.include?(role)
  end

  # Anyone can open the index to their workspaces
  def index?
    true
  end

  def show?
    true
  end

  # Anyone can create workspaces within their own account
  def create?
    true
  end

  def destroy?
    @user.memberships.where(workspace_id: record.id).first.owner?
  end
end
