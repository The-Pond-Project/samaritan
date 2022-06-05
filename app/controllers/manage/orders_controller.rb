# frozen_string_literal: true

module Manage
  class OrdersController < ApplicationController
    before_action :set_order, only: %i[show edit update destroy]

    def index
      @orders = Order.all
    end

    def show; end

    def new
      @order = Order.new
    end

    def edit; end

    def create
      @order = Order.new(order_params)

      if @order.save
        redirect_to manage_order_path(@order), notice: 'Order was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @order.update(order_params)
        redirect_to manage_order_path(@order), notice: 'Order was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @order.destroy
      redirect_to orders_url, notice: 'Order was successfully destroyed.'
    end

    private

    def set_order
      @order = Order.find_by!(uuid: params[:uuid])
    end

    def order_params
      params.require(:order).permit(:amount, :email, :address1, :address2, :postal_code, :region,
                                    :country, :phone, :uuid, :first_name, :city, :last_name)
    end
  end
end
