# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :workspaces, through: :memberships do
    def mine
      where(memberships: { role: Membership.roles[:owner] })
    end

    def others
      where.not(memberships: { role: Membership.roles[:owner] })
    end
  end

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end
  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  has_many :sessions, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 12 }

  normalizes :email, with: -> { _1.strip.downcase }

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end
end
