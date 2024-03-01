# frozen_string_literal: true

class InvitationProcessor
  def self.process_pending_invitations(user)
    Invitation.where(email: user.email).each do |invitation|
      create_membership(user, invitation)
    end
  end

  def self.process_invitation(invitation)
    user = User.find_by(email: invitation.email)
    create_membership(user, invitation) if user
  end

  private
    def self.create_membership(user, invitation)
      Membership.create(user: user, workspace: invitation.workspace, role: invitation.role)
    end
end
