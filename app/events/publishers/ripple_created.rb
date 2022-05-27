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
      return if ripple.ancestors.empty? # Return if this is the first ripple and there are no ancestors to send notifications to.
      broadcast(:alert_ripple_ancestors, ripple)
    end
  end
end
