# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_tag, only: %i[show]

  def index
    @tags = Tag.all.includes([:organization])
  end

  def show; end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to tag_url(@tag.name), notice: 'Tag was successfully created.'

    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_tag
    @tag = Tag.friendly.find_by!(name: params[:name])
  end

  def tag_params
    params.require(:tag).permit(:name, :description, :organization, :approved)
  end
end
