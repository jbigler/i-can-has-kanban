# frozen_string_literal: true

json.array! @workspaces, partial: "workspaces/workspace", as: :workspace
