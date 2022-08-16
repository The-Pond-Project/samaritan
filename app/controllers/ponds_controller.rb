# frozen_string_literal: true

class PondsController < ApplicationController
  before_action :set_pond, only: :show

  def index
    @pagy, @ponds = pagy(Pond.all.order(created_at: :desc))
  end

  def show
    @ripples = @pond.ripples
  end

  private

  def set_pond
    @pond = Pond.friendly.find_by!(key: params[:key].upcase)
  end
end
