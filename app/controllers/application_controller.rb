# frozen_string_literal: true

class ApplicationController < ActionController::Base
  class UnauthorizedUser < StandardError; end
  include Pagy::Backend

  rescue_from UnauthorizedUser, with: :unauthorized_user
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    Honeybadger.notify(exception)
    render 'layouts/record_not_found'
  end

  def unauthorized_user
    Honeybadger.notify(exception)
    render 'layouts/unauthorized_user'
  end

  def admin_logged_in?
    raise UnauthorizedUser unless current_user&.super_admin? || current_user&.admin?
  end

  def super_admin_logged_in?
    raise UnauthorizedUser unless current_user&.super_admin?
  end
end
