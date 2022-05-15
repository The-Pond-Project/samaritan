# frozen_string_literal: true

class TagsController < ApplicationController
  MISSION_FOR_KINDNESS = 'Mission For Kindness'

  before_action :set_tag, only: %i[show]

  def index
    @tags = Tag.approved
  end

  def show; end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    # Tags default to Mission For Kindness
    @tag.organization = Organization.find_by(name: MISSION_FOR_KINDNESS)

    if @tag.save
      msg = 'Tag was successfully submitted. Your tag will be reviewed and approved within 2 days.'
      redirect_to tags_url, notice: msg

    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_tag
    @tag = Tag.friendly.find_by!(name: params[:name])
  end

  def tag_params
    params.require(:tag).permit(:name, :description, :approved)
  end
end
