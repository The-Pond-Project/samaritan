# frozen_string_literal: true

class PagesController < ApplicationController
  def home; end

  def impact; end

  def ripples
    @ripples = Ripple.all.includes([:pond])
  end
end
