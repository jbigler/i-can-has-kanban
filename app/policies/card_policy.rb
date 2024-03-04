# frozen_string_literal: true

# Card Authorization Policy
class CardPolicy < ApplicationPolicy
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
    role = user.memberships.where(workspace_id: record.list.board.workspace.id).first.role
    permitted_roles.include?(role)
  end
end
