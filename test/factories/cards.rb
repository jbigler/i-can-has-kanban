# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    position { 1 }
    list { nil }
    account { nil }
    title { "MyString" }
    description { "MyText" }
  end
end
