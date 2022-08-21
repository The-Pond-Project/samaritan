# frozen_string_literal: true

module Subscribers
  class RippleTextAlert
    class << self
      def alert_subscriber(subscription)
        ripple = Ripple.find_by(uuid: subscription.ripple_uuid)
        if ripple.present?
          message = message(ripple)
          TwilioTextMessenger.message(message: message, to: subscription.phone_number)
        end
      end

      # rubocop:disable Layout/LineLength
      def message(ripple)
        "A ripple was added to the pond! The ripple effect you started continues. Checkout the impact of your ripple here: \n\n#{Routes.pond_ripple_url(ripple.pond, ripple.uuid)}\n\n -ThePondProject"
      end
      # rubocop:enable Layout/LineLength
    end
  end
end
