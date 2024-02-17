# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.find_by(email: "dev@test.com")
user ||= User.create(email: "dev@test.com", name: "Test Developer", password: "this is too long",
                     password_confirmation: "this is too long", verified: true)

workspace = user.workspaces.find_or_create_by(name: "My Test Workspace")
workspace.boards.find_or_create_by(name: "My Test Board 1")
workspace.boards.find_or_create_by(name: "My Test Board 2")

workspace.boards.each do |b|
  (1..3).each do |n|
    b.lists.find_or_create_by(title: "Test List #{n}")
  end

  b.lists.each do |list|
    (1..5).each do |n|
      list.cards.find_or_create_by(title: "Card #{n} on list: #{list.title}")
    end
  end
end
