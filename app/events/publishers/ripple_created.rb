module Publishers
  class RippleCreated < Base
    include Wisper::Publisher
    attr_accessor :ripple

    def initialize(ripple)
      @ripple = ripple
      subscribe(Subscribers::RippleTextAlert, async: true )
    end

    def call
      return unless ripple.present?

      @ancestors = ripple.ancestors
      return if @ancestors.empty? # Return if this is the first ripple and there are no ancestors to send notifications to.
      @ancestors.each do |ripple|
        subscription = MessageSubscription.for(ripple.uuid).first
        broadcast(:alert_subscriber, subscription) if subscription.present?
      end 
    end
  end
end
