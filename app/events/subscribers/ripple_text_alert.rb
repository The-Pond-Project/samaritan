module Subscribers
  class RippleTextAlert

    def self.alert_ripple_ancestors(ripple_uuid)
      ripple = Ripple.find_by(uuid: ripple_uuid)
      ancestors_uuids =  ripple.ancestors.pluck(:uuid)
      alert_ancestors(ancestors_uuids)
    end


    private 

    def alert_ancestors(ancestors)
      subscriptions = MessageSubscription.for(ancestors)
      subscriptions.each do |subscription|
        uuid = subscription.ripple_uuid
        phone_number = subscription.phone_number
        message = message(uuid)
        TwilioTextMessenger.message(message: message, to: phone_number)
      end
    end

    def message(uuid)
      "A ripple was added to the pond! The Ripple effect you started continues.
      Checkout the impact of your ripple here: \n\n #{ripple_url(uuid)}"
    end
  end
end