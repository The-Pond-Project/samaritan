# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_tag, only: %i[show destroy]

  def index
    @tags = Tag.all
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

  def destroy
    @tag.destroy

    redirect_to tags_url, notice: 'Tag was successfully destroyed.'
  end

  private

  def set_tag
    @tag = Tag.find_by(name: params[:name])
  end

  def tag_params
    params.require(:tag).permit(:name, :description, :organization, :approved)
  end
end
