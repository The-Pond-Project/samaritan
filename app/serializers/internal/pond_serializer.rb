# frozen_string_literal: true

module Internal
  class PondSerializer < ActiveModel::Serializer
    attributes :id, :key, :active,
               :postal_code, :region, :city, :country,
               :domestic,
               :impact, :international_impact,
               :created_at, :updated_at

    has_many :ripples

    def active
      object.active?
    end

    def domestic
      object.domestic?
    end
  end
end
