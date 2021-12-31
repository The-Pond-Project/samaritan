# frozen_string_literal: true

class MessageSubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def sms
    response_body = helpers.create_response_body(params)
    response = Twilio::TwiML::MessagingResponse.new do |r|
      r.message body: response_body
    end
    render xml: response.to_s
  end
end
