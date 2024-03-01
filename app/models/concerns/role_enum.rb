# frozen_string_literal: true

module RoleEnum
  extend ActiveSupport::Concern

  included do
    enum role: { owner: 0, admin: 1, editor: 2, viewer: 3 }

    validates :role, inclusion: { in: roles.keys }
  end
end
