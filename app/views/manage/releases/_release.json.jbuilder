# frozen_string_literal: true

json.extract! release, :id, :name, :description, :references, :created_at, :updated_at
json.url release_url(release, format: :json)
