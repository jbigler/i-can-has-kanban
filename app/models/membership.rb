# frozen_string_literal: true

class Membership < ApplicationRecord
  enum role: { owner: 0, admin: 1, editor: 2, viewer: 3 }

  # Setting inverse_of allows the associations to be built
  belongs_to :user, inverse_of: :memberships
  belongs_to :workspace, inverse_of: :memberships

  validates :user_id, uniqueness: { scope: :workspace_id }
end
