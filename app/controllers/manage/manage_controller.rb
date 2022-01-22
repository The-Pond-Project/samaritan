# frozen_string_literal: true

module Manage
  class ManageController < ApplicationController
    def ripples
      @ripples = Ripple.all.includes([:pond])
    end

    def tags
      @tags = Tag.all.includes([:organization])
    end
  end
end
