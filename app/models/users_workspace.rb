# frozen_string_literal: true

class UsersWorkspace < ApplicationRecord
  belongs_to :user
  belongs_to :workspace
end
