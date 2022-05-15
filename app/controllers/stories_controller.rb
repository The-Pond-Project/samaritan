# frozen_string_literal: true

class StoriesController < ApplicationController
  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)

    if @story.save
      redirect_to root_url, notice: 'Story was successfully submitted.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def story_params
    params.require(:story).permit(:title, :body, :pond_key, :ripple_uuid)
  end
end
