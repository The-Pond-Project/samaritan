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
    @tag.organization = Organization.find_by(name: MISSION_FOR_KINDNESS) # Tags default to Mission For Kindness

    if @tag.save
      redirect_to organization_tag_url(@tag.organization, @tag),
                  notice: 'Tag was successfully submitted. Your tag will be reviewed and approved within 2 days.'

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
