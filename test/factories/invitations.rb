# frozen_string_literal: true

FactoryBot.define do
  factory :invitation do
    email { "please@invite.me" }
    transient { user { build(:user_with_workspace) } }
    invited_by { user }
    workspace { user.workspaces.first  }
    role { :editor }
  end
end
