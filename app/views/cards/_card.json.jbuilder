json.extract! card, :id, :position, :list_id, :title, :description, :created_at, :updated_at
json.url card_url(card, format: :json)
