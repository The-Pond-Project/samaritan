# frozen_string_literal: true

class RipplesTag < ApplicationRecord
  extend FriendlyId
  # Schema Information
  # Table name: Ripple Tag
  #
  # id                  :integer      not null, primary key
  # ripple_id           :integer      not null
  # tag_id              :integer      not null
  # deleted_at          :datetime
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  # Associations
  # belongs_to :ripple
  # belongs_to :tag
end
