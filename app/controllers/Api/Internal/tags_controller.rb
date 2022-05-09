# frozen_string_literal: true

module Api
  module Internal
    class TagsController < ::Api::BaseController
      before_action :find_tag, only: [:show]

      def index
        render json: Tag.approved.includes([:organization]),
               each_serializer: ::Internal::TagSerializer
      end

      def show
        render json: @tag, serializer: ::Internal::TagSerializer
      end

      private

      def find_tag
        @tag ||= Tag.find_by!(id: params[:id])
      end
    end
  end
end
