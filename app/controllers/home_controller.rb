# frozen_string_literal: true

# Home Controller
class HomeController < ApplicationController
  def index
    redirect_to workspaces_path if Current.session
  end

  private
    def authenticate
      return unless (session_record = Session.find_by(id: cookies.signed[:session_token]))

      Current.session = session_record
    end
end
