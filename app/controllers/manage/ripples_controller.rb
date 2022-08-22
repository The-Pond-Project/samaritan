# frozen_string_literal: true

module Manage
  class RipplesController < ApplicationController
    before_action :admin_logged_in?
    before_action :set_ripple, only: %i[show edit update destroy]
    before_action :set_pond
    before_action :set_tags, only: %i[create new edit]

    def index
      @ripples = @pond.ripples
    end

    def show; end

    def edit
      @ripple_tags = @ripple.tags
    end

    def new
      @ripple = Ripple.new
    end

    def create
      create_hash = tags_hash.compact.to_h
      @ripple = Ripple.new(ripple_params.merge(create_hash))

      if @ripple.save
        redirect_to manage_ripple_url(@ripple.pond_key, @ripple),
                    notice: 'Ripple was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @ripple.update(ripple_params.merge(tags_hash))
        redirect_to manage_ripple_url(@ripple.pond_key, @ripple),
                    notice: 'Ripple was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @ripple.destroy

      redirect_to manage_ripples_url, notice: 'Ripple was successfully destroyed.'
    end

    private

    def set_ripple
      @ripple = Ripple.friendly.find_by!(uuid: params[:uuid])
    end

    def set_tags
      @tags = Tag.approved
    end

    def set_pond
      @pond = Pond.find_by!(key: params[:pond_key])
    end

    def ripple_params
      params.require(:ripple) \
            .permit(:uuid,
                    :postal_code,
                    :city,
                    :country,
                    :region,
                    :latitude,
                    :longitude,
                    :user_id,
                    :pond_id,
                    :vpn,
                    :precise_location,
                    :county,
                    tags: [])
    end

    def tags_hash
      tags = params[:ripple][:tags]
      @tags_hash = { tags: Tag.find(tags) }
    end
  end
end
