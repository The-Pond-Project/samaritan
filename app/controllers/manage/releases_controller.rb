# frozen_string_literal: true

module Manage
  class ReleasesController < ApplicationController
    before_action :set_release, only: %i[show edit update destroy]
    before_action :set_organization

    def index
      @releases = @organization.releases
    end

    def show; end

    def new
      @release = Release.new
    end

    def edit; end

    def create
      @release = Release.new(release_params)

      if @release.save
        redirect_to manage_organization_release_url(@organization, @release),
                    notice: 'Release was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @release.update(release_params)
        redirect_to manage_organization_release_url(@organization, @release),
                    notice: 'Release was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @release.destroy

      redirect_to manage_organization_releases_url(@organization),
                  notice: 'Release was successfully destroyed.'
    end

    private

    def set_organization
      @organization = Organization.find_by!(name: params[:organization_name])
    end

    def set_release
      @release = Release.friendly.find(params[:id])
    end

    def release_params
      params.require(:release).permit(:name, :description, :organization_id)
    end
  end
end
