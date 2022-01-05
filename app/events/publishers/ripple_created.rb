module Publishers
  class RippleCreated < Base
    attr_accessor :ripple_uuid
    
    def initialize(ripple_uuid)
      @ripple_uuid = ripple_uuid
      subscribe(Subscribers::RippleTextAlert, async: true )
    end

    def call
      ripple = Ripple.find_by(uuid: ripple_uuid)
      return unless ripple
      return if ripple.ancestors.empty? # Return if this is the first ripple and there are no ancestors to send notifications to.
      broadcast(:alert_ripple_ancestors, ripple_uuid)
    end
  end
end