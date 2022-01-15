# frozen_string_literal: true

class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[show]

  def index
    @organizations = Organization.all
  end

  def show; end

  private

  def set_organization
    @organization = Organization.find_by!(name: params[:name])
  end
end
