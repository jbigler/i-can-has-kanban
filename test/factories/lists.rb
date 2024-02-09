# frozen_string_literal: true

FactoryBot.define do
  factory :list do
    account { nil }
    board { nil }
    title { "MyString" }
  end
end
