# frozen_string_literal: true

# Invitation Authorization Policy
class InvitationPolicy < ApplicationPolicy
  def create?
    permitted_roles = Membership.roles.except(:editor, :viewer)
    allowed? permitted_roles
  end

  def allowed?(permitted_roles)
    role = @user.memberships.where(workspace_id: record.workspace.id).first.role
    permitted_roles.include?(role)
  end
end
