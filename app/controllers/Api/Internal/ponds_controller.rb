module Api
  module Internal
    class PondsController < ::Api::BaseController
      before_action :find_pond, only: [:show]

      def index
        render json: Pond.all, each_serializer: ::Internal::PondSerializer
      end

      def show
        render json: @pond, serializer: ::Internal::PondSerializer 
      end

      private

      def find_pond
        @pond ||= Pond.find_by!(id: params[:id])
      end
    end
  end
end