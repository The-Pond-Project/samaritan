# frozen_string_literal: true

module Manage
  class TagsController < ApplicationController
    before_action :admin_logged_in?
    before_action :set_tag, only: %i[show edit update destroy]
    before_action :set_organizations, only: %i[new edit]

    def index
      @tags = Tag.all.includes([:organization])
    end

    def show; end

    def edit; end

    def new
      @tag = Tag.new
    end

    def create
      @tag = Tag.new(tag_params)

      if @tag.save
        redirect_to manage_tag_url(@tag), notice: 'Tag was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @tag.update(tag_params)
        redirect_to manage_tag_path(@tag),
                    notice: 'Tag was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @tag.destroy

      redirect_to manage_tags_url, notice: 'Tag was successfully destroyed.'
    end

    private

    def set_tag
      @tag = Tag.friendly.find_by!(name: params[:name])
    end

    def set_organizations
      @organizations = Organization.all
    end

    def tag_params
      params.require(:tag).permit(:name, :description, :organization_id, :approved)
    end
  end
end
