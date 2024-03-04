# frozen_string_literal: true

class InvitationPolicy < ApplicationPolicy
  def create?
    permitted_roles = Invitation.roles.except(:editor, :viewer)
    allowed?(permitted_roles) unless [@user.email, record.workspace.owner.email].include?(record.email)
  end

  def allowed?(permitted_roles)
    if !record.owner?
      role = @user.memberships.find_by(workspace_id: record.workspace.id).role
      permitted_roles.include?(role)
    end
  end
end
