# frozen_string_literal: true

class ReleasesController < ApplicationController
  before_action :set_release,  only: :show
  before_action :set_organization

  def index
    @releases = @organization.releases
  end

  def show; end

  private

  def set_release
    @release = Release.friendly.find(params[:id])
  end

  def set_organization
    @organization = Organization.find_by!(name: params[:organization_name])
  end
end
