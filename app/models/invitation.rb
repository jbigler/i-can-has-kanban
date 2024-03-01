# frozen_string_literal: true

class Invitation < ApplicationRecord
  include RoleEnum

  belongs_to :invited_by, class_name: "User"
  belongs_to :workspace

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :invited_by, presence: true
  validates :workspace, presence: true

  normalizes :email, with: -> { _1.strip.downcase }
end
