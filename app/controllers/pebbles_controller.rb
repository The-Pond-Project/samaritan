# frozen_string_literal: true

class PebblesController < ApplicationController
  before_action :set_pebble, only: :show

  def index
    @pebbles = Pebble.all
  end

  def show
    @ripples = @pebble.ripples
  end

  private

  def set_pebble
    @pebble = Pebble.find_by!(pebble_key: params[:pebble_key])
  end
end
