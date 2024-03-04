# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :set_workspace, only: %i[index new create]
  before_action :set_membership, only: %i[show edit update destroy]

  def index
    @memberships = @workspace.memberships
    authorize :membership
  end

  def show
  end

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
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to workspace_members_url(@membership.workspace), notice: "Member was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    workspace = @membership.workspace
    @membership.destroy!

    respond_to do |format|
      format.html { redirect_to workspace_members_url(workspace), notice: "Member was successfully removed." }
    end
  end

  private
    def set_membership
      @membership = Membership.find(params[:id])
      authorize @membership
    end

    def set_workspace
      @workspace = Current.user.workspaces.find(params[:workspace_id])
    end

    def send_invitation_email
      InvitationMailer.with(invitation: @invitation).invitation_email.deliver_later
    end

    # Only allow a list of trusted parameters through.
    def invitation_params
      params.require(:invitation).permit(:member_id, :email, :role)
    end

    def membership_params
      params.require(:membership).permit(:role)
    end
end
