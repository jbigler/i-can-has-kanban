# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "Test User" }
    sequence(:email) { |n| "test#{n}@test.abc" }
    password { "Secret1*3*5*" }
    password_digest { BCrypt::Password.create("Secret1*3*5*") }
    verified { true }
  end

  factory :user_with_workspace, parent: :user do
    workspaces { [association(:workspace)] }
  end

  factory :user_with_3_workspaces, parent: :user do
    transient do
      workspaces_count { 3 }
    end

    workspaces do
      Array.new(workspaces_count) { association(:workspace) }
    end
  end
end
