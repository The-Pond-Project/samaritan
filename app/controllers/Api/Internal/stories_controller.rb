module Api
  module Internal
    class StoriesController < ::Api::BaseController
      before_action :find_story, only: [:show]

      def index
        render json: Story.all, each_serializer: ::Internal::StorySerializer
      end

      def show
        render json: @story, serializer: ::Internal::StorySerializer
      end

      private

      def find_story
        @story ||= Story.find_by!(id: params[:id])
      end
    end
  end
end