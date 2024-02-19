# frozen_string_literal: true

# Base Application Controller
class ApplicationController < ActionController::Base
  before_action :set_current_request_details
  before_action :authenticate
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def authenticate
    if (session_record = Session.find_by(id: cookies.signed[:session_token]))
      Current.session = session_record
    else
      redirect_to sign_in_path
    end
  end

  def set_current_request_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end

  def pundit_user
    Current.user
  end

  def user_not_authorized
    flash.now[:notice] = "You are not authorized to perform this action."
  end
end
