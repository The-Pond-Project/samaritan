module Internal
  class ReleaseSerializer < ActiveModel::Serializer
    attributes :id, :name, :description, :created_at

    has_many :ponds
  end
end 