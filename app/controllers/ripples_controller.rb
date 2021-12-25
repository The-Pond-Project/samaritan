# frozen_string_literal: true

class RipplesController < ApplicationController
  before_action :set_ripple, only: %i[show destroy]
  before_action :set_pond, only: %i[new]
  before_action :set_location, only: %i[create]

  def index
    @ripples = Ripple.all.includes([:pond])
  end

  def show; end

  def new
    @ripple = Ripple.new
  end

  def create
    @ripple = Ripple.new(ripple_params.merge(@location_hash))
    @ripple.user = current_user

    if @ripple.save
      redirect_to ripple_url(@ripple.uuid), notice: 'Ripple was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @ripple.destroy

    redirect_to ripples_url, notice: 'Ripple was successfully destroyed.'
  end

  private

  def set_ripple
    @ripple = Ripple.find_by!(uuid: params[:uuid])
  end

  def set_pond
    @pond = Pond.find_by!(key: params[:key])
  end

  def set_location
    ip = request.remote_ip
    result = Geocoder.search(ip).first
    @location_hash = {
      country: result.country,
      region: result.region,
      city: result.city,
      postal_code:
                        result.postal_code,
    }
  end

  def ripple_params
    params.require(:ripple).permit(:uuid, :postal_code, :city, :country, :region, :user_id,
                                   :pond_id)
  end
end
