module Internal
  class RippleSerializer < ActiveModel::Serializer
    attributes :id, :pond_key, :postal_code, :region, :city,
      :country, :created_at, :updated_at, :impact, :international_impact

  end
end