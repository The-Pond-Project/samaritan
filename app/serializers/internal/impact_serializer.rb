# frozen_string_literal: true

module Internal
  class ImpactSerializer < ActiveModel::Serializer
    attributes :ponds, :largest_pond,
               :ripples, :international_ripples, :domestic_ripples,
               :releases, :average_release_size,
               :organizations

    def ponds
      Pond.count
    end

    def largest_pond
      Ripple.largest_pond
    end

    def ripples
      Ripple.count
    end

    def international_ripples
      Ripple.international.count
    end

    def domestic_ripples
      Ripple.domestic.count
    end

    def releases
      Release.count
    end

    def average_release_size
      Release.average_release_size
    end

    def organizations
      Organization.count
    end
  end
end
