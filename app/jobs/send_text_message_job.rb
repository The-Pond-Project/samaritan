# frozen_string_literal: true

class SendTextMessageJob < ApplicationJob
  queue_as :text_messages

  def perform(to:, message:)
    TwilioTextMessenger.message(message: message, to: to)
  end
end
