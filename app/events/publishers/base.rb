# frozen_string_literal: true

module Publishers
  include Wisper::Publisher
  class Base
    def self.call(*args)
      new(*args).call
    end
  end
end
