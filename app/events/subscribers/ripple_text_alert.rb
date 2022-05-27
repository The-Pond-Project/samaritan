module Subscribers
  class RippleTextAlert
    class << self
      def alert_ripple_ancestors(ripple)
        ancestors_uuids = ripple.ancestors.pluck(:uuid)
        alert_ancestors(ancestors_uuids)
      end

      def alert_ancestors(ancestors)
        subscriptions = MessageSubscription.for(ancestors)
        subscriptions.each do |subscription|
          ripple = Ripple.find_by(uuid: subscription.ripple_uuid)
          message = message(ripple)
          TwilioTextMessenger.message(message: message, to: subscription.phone_number)
        end
      end
  
      def message(ripple)
        "A ripple was added to the pond! The Ripple effect you started continues.
        Checkout the impact of your ripple here: \n\n #{Routes.pond_ripple_url(ripple.pond, ripple.uuid)}"
      end
    end
  end
end 