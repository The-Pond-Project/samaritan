require 'csv'

module Manage
  class PondBatchCreationController < ApplicationController
    before_action :set_release, :set_organization, :creator

    def new; end

    def create
      creator.create_ponds
      if creator.success?
        success_msg = "#{creator.amount} ponds were sucessfully created"
        # send_data @csv_file
        redirect_to manage_organization_release_path(@organization, @release), notice: success_msg
      else
        render :new, status: :unprocessable_entity
      end
    end

    private 

    def set_release
      @release = Release.friendly.find_by!(slug: params[:release_id])
    end

    def set_organization
      @organization = Organization.find_by!(name: params[:organization_name])
    end

    def creator
      @creator ||= PondBatchCreator.new(
        amount: params[:amount],
        location: params[:location], 
        release_id: @release.id, 
        unique_code: params[:unique_code]
      )
    end

    def csv_file
      attributes = ['organization', 'key', 'uuid', 'location', 'created_at']
      @csv_file ||= ::CSV.generate( headers: true) do |csv|
                        csv << attributes
                        creator.ponds.each do |pond|
                          csv << [pond.organization.name, pond.key, pond.uuid, pond.full_location, pond.created_at]
                        end
                      end
    end
  end
end 
