# frozen_string_literal: true

class DonationsController < ApplicationController
  before_action :validate_params

  def create
    session = Stripe::Checkout::Session.create(stripe_params)
    @session_id = session.id
  end

  private

  def validate_params
    unless amount.present? && amount.to_i >= 1
      redirect_to donate_url, alert: 'Please enter an amount of at least $1.'
    end
  end

  def stripe_params
    {
      payment_method_types: ['card'],
      customer: nil,
      client_reference_id: nil,
      customer_email: email,
      line_items: line_items,
      success_url: Routes.thank_you_url,
      cancel_url: Routes.donate_url,
    }
  end

  def line_items
    [
      {
        quantity: 1,
        name: 'Charitable Donation',
        amount: (amount * 100).to_i,
        currency: 'USD',
        description: 'Donation to MissionForKindness. Thank you for your generosity!',
      },
    ]
  end

  def amount
    params[:amount]&.to_f
  end

  def email
    params[:email]
  end
end
