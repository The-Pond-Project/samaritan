# frozen_string_literal: true

module Manage
  class StoriesController < ApplicationController
    before_action :admin_logged_in?
    before_action :set_story, only: %i[show edit update destroy]

    def index
      @stories = Story.all
    end

    def new
      @story = Story.new
    end

    def show; end

    def edit; end

    def create
      @story = Story.new(story_params)

      if @story.save
        redirect_to manage_stories_path(@story), notice: 'Story was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @story.update(story_params)
        redirect_to manage_story_url(@story),
                    notice: 'Story was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @story.destroy
      redirect_to manage_stories_url, notice: 'Story was successfully destroyed.'
    end

    private

    def story_params
      params.require(:story).permit(:title, :body, :pond_key, :ripple_uuid)
    end

    def set_story
      @story = Story.find_by!(uuid: params[:uuid])
    end
  end
end
