# frozen_string_literal: true

module Internal
  class TagSerializer < ActiveModel::Serializer
    attributes :id, :name, :description, :created_at

    belongs_to :organization
  end
end
