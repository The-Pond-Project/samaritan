# frozen_string_literal: true

class PagesController < ApplicationController
  def home; end

  def impact; end

  def privacy_policy; end

  def terms; end

  def donate
    @bills = Bill.all
  end

  def contribute; end

  def ripples
    @ripples = Ripple.all.includes([:pond])
  end
end
