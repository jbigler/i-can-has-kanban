# frozen_string_literal: true

# Workspace
class Workspace < ApplicationRecord
  has_many :memberships, dependent: :delete_all
  has_many :members, through: :memberships, source: :user
  has_many :boards, dependent: :destroy
  has_many :invitations, dependent: :destroy

  def owner
    members.where(memberships: { role: Membership.roles[:owner] }).first
  end

  def other_members
    members.where.not(memberships: { role: Membership.roles[:owner] })
  end
end
