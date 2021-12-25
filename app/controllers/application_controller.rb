# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 


  private 

  def record_not_found
    render 'layouts/record_not_found'
  end
end
