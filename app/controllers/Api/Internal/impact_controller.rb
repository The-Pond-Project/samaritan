# frozen_string_literal: true

module Api
  module Internal
    class ImpactController < ::Api::BaseController
      class ::Impact
        extend ActiveModel::Naming
        include ActiveModel::Serialization
      end

      def show
        render json: ::Impact.new, serializer: ::Internal::ImpactSerializer
      end

      def count
        render json: { count: Pond.count }
      end
    end
  end
end
