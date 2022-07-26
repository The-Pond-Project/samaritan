# frozen_string_literal: true

require 'csv'
require 'base64'

module Manage
  class PondBatchRecordController < ApplicationController
    before_action :set_release, :set_organization, :creator

    def new; end

    def create
      ponds = creator.create_ponds
      if creator.success?
        filename = 'my_archive.zip'
        temp_file = Tempfile.new(filename)
        Zip::OutputStream.open(temp_file) { |zos| }

        Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
          ponds.each do |pond|
            image_file = Tempfile.new("#{pond.organization.image.created_at.in_time_zone}.png")
            
          # image_file.write(product.attachment.image_string) #this does not work for ActiveStorage attachments
            
            # use this instead
            File.open(image_file.path, 'wb', encoding: 'ASCII-8BIT') do |file|
              pond.organization.image.download do |chunk|
                byebug
                file.write(chunk)
              end
            end

            zip.add("#{pond.organization.image.created_at.in_time_zone}.png", image_file.path)
          end
        end

        zip_data = File.read(temp_file.path)
        send_data(zip_data, type: 'application/zip', disposition: 'attachment', filename: filename)

        temp_file.close
        temp_file.unlink
        # success_msg = "#{creator.amount} pond(s) were sucessfully created"
        # redirect_to manage_organization_release_path(@organization, @release), notice: success_msg
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
