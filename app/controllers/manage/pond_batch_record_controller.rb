# frozen_string_literal: true

require 'csv'

module Manage
  class PondBatchRecordController < ApplicationController
    before_action :set_release, :set_organization, :creator

    def new; end

    def create
      creator.create_ponds
      if creator.success?
        success_msg = "#{creator.amount} pond(s) were sucessfully created"
        redirect_to manage_organization_release_path(@organization, @release), notice: success_msg
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_release
      @release = Release.friendly.find_by(slug: params[:release_id])
      @release = Release.friendly.find_by(id: params[:release_id]) if @release.nil?
    end

    def set_organization
      @organization = Organization.find_by!(name: params[:organization_name])
    end

    def creator
      @creator ||= ::PondBatchCreator.new(
        amount: params[:amount],
        location: params[:location],
        release_id: @release.id,
        unique_code: params[:unique_code]
      )
    end
  end
end
