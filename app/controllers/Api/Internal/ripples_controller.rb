# frozen_string_literal: true

module Api
  module Internal
    class RipplesController < ::Api::BaseController
      before_action :find_ripple, only: [:show]

      def index
        render json: Ripple.all.includes([:pond]), each_serializer: ::Internal::RippleSerializer
      end

      def show
        render json: @ripple, serializer: ::Internal::RippleSerializer
      end

      private

      def find_ripple
        @ripple ||= Ripple.find_by!(id: params[:id])
      end
    end
  end
end
