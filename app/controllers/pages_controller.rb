# frozen_string_literal: true

class PagesController < ApplicationController
  def home; end

  def impact; end

  def privacy_policy; end

  def terms; end

  def thank_you; end

  def explained; end

  def contribute; end

  def partner; end

  def donate
    redirect_to root_path unless Flipper.enabled?(:pond_project_donations)

    @bills = Bill.this_year
  end

  def ripples
    @pagy, @ripples = pagy(Ripple.all.order(created_at: :desc).includes([:pond]))
  end
end
