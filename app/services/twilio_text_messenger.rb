# frozen_string_literal: true

class TwilioTextMessenger
  attr_reader :message, :to

  def initialize(message, to)
    @to = to
    @message = message
  end

  def self.message(message:, to:)
    new(message, to).send_message
  end

  def send_message
    client.messages.create(
      from: from,
      to: to,
      body: message
    )
  end

  private

  def account_sid
    Rails.application.credentials.dig(:twilio, :twilio_account_sid)
  end

  def auth_token
    Rails.application.credentials.dig(:twilio, :twilio_auth_token)
  end

  def client
    Twilio::REST::Client.new(account_sid, auth_token)
  end

  def from
    "+#{Rails.application.credentials.dig(:twilio, :twilio_phone_number)}"
  end
end
