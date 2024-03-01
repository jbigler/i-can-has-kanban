# frozen_string_literal: true

class InvitationMailer < ApplicationMailer
  def invitation_email
    @invitation = params[:invitation]

    mail to: @invitation.email, subject: "You have been invited to join #{@invitation.workspace.name}"
  end
end
