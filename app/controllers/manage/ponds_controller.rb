# frozen_string_literal: true

module Manage
  class PondsController < ApplicationController
    before_action :admin_logged_in?
    before_action :set_pond, only: %i[show edit update destroy]

    def index
      @ponds = Pond.all
    end

    def show
      @ripples = @pond.ripples
    end

    def new
      @pond = Pond.new
    end

    def edit; end

    def create
      @pond = Pond.new(pond_params)
      if @pond.save
        redirect_to manage_pond_url(@pond),
                    notice: 'Pond was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @pond.update(pond_params)
        redirect_to manage_pond_url(@pond.key),
                    notice: 'Pond was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @pond.destroy
      redirect_to manage_ponds_url, notice: 'Pond was successfully destroyed.'
    end

    private

    def set_pond
      @pond = Pond.friendly.find_by!(key: params[:key])
    end

    def pond_params
      params.require(:pond).permit(:uuid, :key, :postal_code, :region, :city, :country)
    end
  end
end
