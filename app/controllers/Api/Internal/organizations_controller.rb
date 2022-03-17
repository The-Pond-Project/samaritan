module Api
  module Internal
    class OrganizationsController < ::Api::BaseController
      before_action :find_organization, only: [:show]

      def index
        render json: Organization.all, each_serializer: ::Internal::OrganizationSerializer
      end

      def show
        render json: @organization, serializer: ::Internal::OrganizationSerializer
      end

      private

      def find_organization
        @organization ||= Organization.find_by!(id: params[:id])
      end
    end
  end
end