# frozen_string_literal: true

class RipplesController < ApplicationController
  before_action :set_ripple, only: %i[show]
  before_action :set_pond, only: %i[new index]
  before_action :set_location, only: %i[create]
  before_action :set_tags, only: %i[create new]

  def index
    @ripples = @pond.ripples
  end

  def show; end

  def new
    @tags = Tag.approved
    @ripple = Ripple.new
  end

  def create
    create_hash = [*@location_hash, *tags_hash].compact.to_h
    @ripple = Ripple.new(ripple_params.merge(create_hash))
    @ripple.user = current_user

    if @ripple.save
      redirect_to pond_ripples_url(@ripple.pond_key, @ripple.uuid),
                  notice: 'Ripple was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
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

  def set_location
    ip = request.remote_ip
    result = Geocoder.search(ip).first
    @location_hash = {
      country: result.country,
      region: result.region,
      city: result.city,
      postal_code: result.postal_code,
      longitude: result.longitude,
      latitude: result.latitude,
    }
  end

  def ripple_params
    params.require(:ripple).permit(:uuid, :postal_code, :city, :country, :region, :latitude, :longitude, :user_id,
                                   :pond_id)
  end

  def tags_hash
    tags = params[:ripple][:tags]
    @tags_hash = { tags: Tag.find(tags) }
  end
end
