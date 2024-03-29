# frozen_string_literal: true

module Manage
  class OrdersController < ApplicationController
    before_action :set_order, only: %i[show edit update destroy send_message]

    def index
      @unshipped_orders = Order.needs_shipped
      @shipped_orders = Order.shipped
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
        if only_shipped_updated?
          redirect_to manage_orders_path, notice: 'Order shipped status was successfully updated.'
        else
          redirect_to manage_order_path(@order), notice: 'Order was successfully updated.'
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @order.destroy
      redirect_to manage_orders_url, notice: 'Order was successfully destroyed.'
    end

    def send_message
      if @order.phone.present?
        SendTextMessageJob.new.perform(message: order_sent_message, to: @order.phone)
        redirect_to manage_orders_path, notice: 'Message was sent.'
      else
        redirect_to manage_orders_path, notice: 'Message cannot be sent.'
      end
    end

    private

    # rubocop:disable Layout/LineLength
    def order_sent_message
      "Your order of KindCards was shipped! Delivery can take between 1-5 days. If it has been longer than 5 days, please reply back ORDER NOT RECEIVED. Thank you for your order and your commitment to kindness.\n\n -ThePondProject"
    end
    # rubocop:enable Layout/LineLength

    def set_order
      @order = Order.find_by!(uuid: params[:uuid])
    end

    def order_params
      params.require(:order).permit(:amount, :email, :address1, :address2, :postal_code, :region,
                                    :country, :phone, :uuid, :first_name, :city, :last_name,
                                    :shipped)
    end

    def only_shipped_updated?
      order_params.key?(:shipped) && order_params.keys.count == 1
    end
  end
end
