# frozen_string_literal: true

json.extract! pond, :id, :uuid, :postal_code, :city, :region, :country, :key, :created_at,
              :updated_at
json.url pond_url(pond, format: :json)
