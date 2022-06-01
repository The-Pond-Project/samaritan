# frozen_string_literal: true

class PagesController < ApplicationController
  def home; end

  def impact; end

  def privacy_policy; end

  def terms; end

  def thank_you; end

  def explained; end

  def contribute; end

  def donate
    @bills = Bill.this_year
  end

  def ripples
    @ripples = Ripple.all.includes([:pond])
  end
end
