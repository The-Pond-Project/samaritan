# frozen_string_literal: true

module Internal
  class OrganizationSerializer < ActiveModel::Serializer
    attributes :id, :name, :description,
               :website, :image, :address, :created_at

    has_many :releases

    def image
      Rails.application.routes.url_helpers.rails_blob_url(object.image)
    end
  end
end
