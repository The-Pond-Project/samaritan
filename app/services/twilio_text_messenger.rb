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
    EnvSecret.get('TWILIO_ACCOUNT_SID')
  end

  def auth_token
    EnvSecret.get('TWILIO_AUTH_TOKEN')
  end

  def client
    Twilio::REST::Client.new(account_sid, auth_token)
  end

  def from
    "+#{EnvSecret.get('TWILIO_PHONE_NUMBER')}"
  end
end
