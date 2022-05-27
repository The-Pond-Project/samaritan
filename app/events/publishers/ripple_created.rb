# frozen_string_literal: true

module Publishers
  class RippleCreated < Base
    include Wisper::Publisher
    attr_accessor :ripple

    # rubocop:disable Lint/MissingSuper
    def initialize(ripple)
      @ripple = ripple
      subscribe(Subscribers::RippleTextAlert, async: true)
    end

    def call
      return if ripple.blank?

      @ancestors = ripple.ancestors
      return if @ancestors.empty?

      @ancestors.each do |ripple|
        subscription = MessageSubscription.for(ripple.uuid).first
        broadcast(:alert_subscriber, subscription) if subscription.present?
      end
    end
    # rubocop:enable Lint/MissingSuper
  end
end
