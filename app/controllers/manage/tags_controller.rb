# frozen_string_literal: true

module Manage
  class TagsController < ApplicationController
    before_action :admin_logged_in?
    before_action :set_tag, only: %i[show edit update destroy]
    before_action :set_organizations, only: %i[new edit create]
    before_action :set_organization, only: %i[index show]

    def tags
      @tags = Tag.all.includes([:organization])
    end

    def index
      @tags = @organization.tags
    end

    def show; end

    def edit; end

    def new
      @tag = Tag.new
    end

    def create
      @tag = Tag.new(tag_params)

      if @tag.save
        redirect_to manage_organization_tag_url(@tag.organization, @tag),
                    notice: 'Tag was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @tag.update(tag_params)
        if only_approved_updated?
          redirect_to manage_tags_path, notice: 'Tag approval status was successfully updated.'
        else 
          redirect_to manage_organization_tag_path(@tag.organization, @tag), notice: 'Tag was successfully updated.'
        end 
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @tag.destroy

      redirect_to manage_tags_path,
                  notice: 'Tag was successfully destroyed.'
    end

    private

    def set_tag
      @tag = Tag.friendly.find_by!(name: params[:name])
    end

    def set_organizations
      @organizations = Organization.all
    end

    def set_organization
      @organization = Organization.find_by!(name: params[:organization_name])
    end

    def tag_params
      params.require(:tag).permit(:name, :description, :organization_id, :approved)
    end

    def only_approved_updated?
      tag_params.key?(:approved) && tag_params.keys.count == 1
    end
  end
end
