# frozen_string_literal: true

json.extract! pebble, :id, :uuid, :postal_code, :city, :region, :country, :pebble_key, :created_at,
              :updated_at
json.url pebble_url(pebble, format: :json)
