# frozen_string_literal: true

class Workspace < ApplicationRecord
  has_many :users_workspaces, dependent: :delete_all
  has_many :users, through: :users_workspaces
  has_many :boards, dependent: :destroy
end
