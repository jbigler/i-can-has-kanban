# frozen_string_literal: true

# Workspace
class Workspace < ApplicationRecord
  has_many :memberships, dependent: :delete_all
  has_many :users, through: :memberships
  has_many :boards, dependent: :destroy
  has_many :invitations, dependent: :destroy

  def owner
    users.where(memberships: { role: Membership.roles[:owner] }).first
  end
end
