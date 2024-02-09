# frozen_string_literal: true

json.extract! board, :id, :workspace_id, :name, :created_at, :updated_at
json.url board_url(board, format: :json)
