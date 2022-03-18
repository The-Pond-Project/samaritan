module Internal
  class StorySerializer < ActiveModel::Serializer
    attributes :id, :title, :body, :pond_key, :uuid

  end
end 