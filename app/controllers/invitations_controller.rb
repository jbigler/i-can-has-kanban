# frozen_string_literal: true

class InvitationsController < ApplicationController
  before_action :set_workspace, only: %i[new create]

  def new
    @invitation = @workspace.invitations.new(invited_by: Current.user)
    authorize @invitation
  end

  def create
    @invitation = @workspace.invitations.new(invitation_params)
    @invitation.invited_by = Current.user
    authorize @invitation

    respond_to do |format|
      if @invitation.save
        send_invitation_email
        InvitationProcessor.process_invitation(@invitation)
        format.html { redirect_to workspace_url(@workspace), notice: "Invitation was successfully sent." }
        format.json { render :show, status: :created, location: @invitation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_workspace
      @workspace = Current.user.workspaces.find(params[:workspace_id])
    end

    def send_invitation_email
      InvitationMailer.with(invitation: @invitation).invitation_email.deliver_later
    end

    # Only allow a list of trusted parameters through.
    def invitation_params
      params.require(:invitation).permit(:email, :role)
    end
end
