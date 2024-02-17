# frozen_string_literal: true

json.extract! card, :id, :row_order_position, :list_id, :title, :description, :created_at, :updated_at
json.url card_url(card, format: :json)
