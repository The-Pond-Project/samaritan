# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[show]

  def show; end

  def new
    @order = Order.new
  end

  def create
    return unless Flipper.enabled?(:kindcard_orderable)

    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
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
