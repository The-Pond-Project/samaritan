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

  # rubocop:disbable Metrics/AbcSize
  def create
    create_hash = [*@location_hash, *tags_hash].compact.to_h
    @ripple = Ripple.new(ripple_params.merge(create_hash))

    if @ripple.save
      if message_subscription_params.present? && Flipper.enabled?(:text_subscriptions)
        create_message_subscription
      end
      redirect_to pond_ripple_url(@ripple.pond_key, @ripple.uuid),
                  notice: 'Ripple was successfully recorded.'
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

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable MMetrics/AbcSize
  def set_location
    ip = request.remote_ip
    @location_response ||= Client::Geolocation.get_location_from_ip_address(ip)
    if precise_location
      latitude = params.dig('ripple', 'latitude')
      longitude = params.dig('ripple', 'longitude')
      address = Google::ReverseAddress.new(latitude: latitude, longitude: longitude)
      @location_hash = {
        country: address.try(:country),
        region: address.try(:region),
        city: address.try(:city),
        postal_code: address.try(:postal_code),
        longitude: address.try(:longitude),
        latitude: address.try(:latitude),
        vpn: @location_response.dig('security', 'is_vpn'),
        county: address.try(:county),
        precise_location: precise_location,
      }
    else
      @location_hash = {
        country: @location_response['country'],
        region: @location_response['region'],
        city: @location_response['city'],
        postal_code: @location_response['postal_code'],
        longitude: @location_response['longitude'],
        latitude: @location_response['latitude'],
        vpn: @location_response.dig('security', 'is_vpn'),
        county: @location_response.try(:county),
        precise_location: precise_location,
      }
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable MMetrics/AbcSize

  def precise_location
    params.dig('ripple', 'latitude').present? && params.dig('ripple', 'longitude').present?
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
                  :vpn)
  end

  def message_subscription_params
    params.permit(:phone_number)
  end

  def tags_hash
    tags = params[:ripple][:tags]
    @tags_hash = tags.present? ? { tags: Tag.find(tags) } : { tags: [] }
  end

  def create_message_subscription
    phone_number = message_subscription_params[:phone_number]
    MessageSubscription.create(phone_number: phone_number, ripple_uuid: @ripple.uuid)
  end
end
