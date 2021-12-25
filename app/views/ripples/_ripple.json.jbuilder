# frozen_string_literal: true

json.extract! ripple, :id, :uuid, :postal_code, :city, :country, :region, :user_id, :pebble_id,
              :created_at, :updated_at
json.url ripple_url(ripple, format: :json)
