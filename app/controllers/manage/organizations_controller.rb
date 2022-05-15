# frozen_string_literal: true

module Manage
  class OrganizationsController < ApplicationController
    before_action :admin_logged_in?
    before_action :set_organization, only: %i[show edit update destroy]

    def index
      @organizations = Organization.all.joins(:image_attachment)
    end

    def show; end

    def new
      @organization = Organization.new
    end

    def edit; end

    def create
      @organization = Organization.new(organization_params)
      if @organization.save
        redirect_to manage_organization_url(@organization.name),
                    notice: 'Organization was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @organization.update(organization_params)
        redirect_to manage_organization_url(@organization.name),
                    notice: 'Organization was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @organization.destroy
      redirect_to manage_organizations_url, notice: 'Organization was successfully destroyed.'
    end

    private

    def set_organization
      @organization = Organization.find_by!(name: params[:name])
    end

    def organization_params
      params.require(:organization).permit(:name, :description, :address, :website, :image)
    end
  end
end
