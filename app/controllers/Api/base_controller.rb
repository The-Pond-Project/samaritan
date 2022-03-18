module Api
  class BaseController < ActionController::API
    before_action :authorize
    API_KEY = Rails.application.credentials.dig(:internal_api_key)

    private 

    def authorize
      head 401 unless samaritan_client? && authorized?
    end

    def samaritan_client?
      request.headers['X-SamaritanClient-Key'].present?
    end

    def authorized?
      bearer_token = request.headers['Authorization']
      bearer_token.present? && \
        bearer_token.split(' ').second == API_KEY
    end
  end
end