# frozen_string_literal: true

module Manage
  class ManageController < ApplicationController
    def ripples
      @ripples = Ripple.all.includes([:pond])
    end
  end
end
