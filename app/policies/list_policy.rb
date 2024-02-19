# frozen_string_literal: true

# Board Authorization Policy
class ListPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    permitted_roles = Membership.roles.except(:viewer)
    allowed? permitted_roles
  end

  def update?
    permitted_roles = Membership.roles.except(:viewer)
    allowed? permitted_roles
  end

  def destroy?
    permitted_roles = Membership.roles.except(:viewer)
    allowed? permitted_roles
  end

  def allowed?(permitted_roles)
    role = @user.memberships.where(workspace_id: record.board.workspace.id).first.role
    permitted_roles.include?(role)
  end
end
