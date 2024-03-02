# frozen_string_literal: true

class MembershipPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    permitted_roles = Membership.roles.except(:editor, :viewer)
    allowed? permitted_roles
  end

  def update?
    permitted_roles = Membership.roles.except(:editor, :viewer)
    allowed? permitted_roles
  end

  def destroy?
    permitted_roles = Membership.roles.except(:editor, :viewer)
    allowed? permitted_roles
  end

  def allowed?(permitted_roles)
    role = @user.memberships.find_by(workspace_id: record.workspace.id).role
    permitted_roles.include?(role)
  end
end
