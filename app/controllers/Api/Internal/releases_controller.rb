module Api
  module Internal
    class ReleasesController < ::Api::BaseController
      before_action :find_release, only: [:show]

      def index
        render json: Release.all.includes([:ponds]), each_serializer: ::Internal::ReleaseSerializer
      end

      def show
        render json: @release, serializer: ::Internal::ReleaseSerializer
      end

      private

      def find_release
        @release ||= Release.find_by!(id: params[:id])
      end
    end
  end
end