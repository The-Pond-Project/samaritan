# frozen_string_literal: true

module Manage
  class ManageController < ApplicationController
    def dashboard; end

    def ripples
      @ripples = Ripple.all.includes([:pond])
    end

    def releases
      @releases = Release.all.includes([:organization])
    end

    def tags
      @tags = Tag.all.includes([:organization])
    end
  end
end
