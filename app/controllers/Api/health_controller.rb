# frozen_string_literal: true

module Api
  class HealthController < BaseController
    skip_before_action :authorize

    def ping
      render json: { status: 'All Good' }
    end
  end
end
