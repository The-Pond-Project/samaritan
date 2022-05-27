module Subscribers
  class RippleTextAlert
    class << self
      def alert_subscriber(subscription)
        ripple = Ripple.find_by(uuid: subscription.ripple_uuid)
        message = message(ripple)
        TwilioTextMessenger.message(message: message, to: subscription.phone_number)
      end
  
      def message(ripple)
        "A ripple was added to the pond! The Ripple effect you started continues.
        Checkout the impact of your ripple here: \n\n #{Routes.pond_ripple_url(ripple.pond, ripple.uuid)}"
      end
    end
  end
end 