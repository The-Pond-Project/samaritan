# frozen_string_literal: true

module MessageSubscriptionsHelper
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/PerceivedComplexity
  def create_response_body(params)
    parse_body = params[:Body]&.strip&.split(' ')
    command ||= parse_body&.first&.upcase
    uuid ||= parse_body&.last
    from ||= params[:From]

    case command

    when 'SUBSCRIBE'
      ripple = Ripple.find_by(uuid: uuid)
      if ripple
        MessageSubscription.create(phone_number: from, ripple_uuid: uuid)
        "The number #{from} has been subscribed to receive updates on your ripple.
          \n\n Text UNSUBSCRIBE at any time to unsubscribe."
      else
        "The ripple id (#{uuid}) is not valid. Please check your ripple id and try again.
        Ripple id format: xxxxx-xxxx-xxxxx-xxxx-xxxxx
        \n\n Text UNSUBSCRIBE at any time to unsubscribe."
      end
    when 'UNSUBSCRIBE'
      subscriber = MessageSubscription.find_by(phone_number: from)
      if subscriber&.destroy
        "The number #{from} has been unsubscribed. Text SUBSCRIBE at any time to resubscribe."
      else
        "Sorry, I did not find a subscription with the number #{from}."
      end
    else
      "Sorry I didn't get that. The available commands are SUBSCRIBE ripple-id-here
                                                                    and UNSUBSCRIBE."
    end
  end
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/CyclomaticComplexity
end
