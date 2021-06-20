# frozen_string_literal: true

class ApplicationController < ActionController::API
  # JSON API modules
  include JSONAPI::Fetching
  include JSONAPI::Errors

  def correct_user
    current_user.employee.eql?(true)
  end

  def check_permission
    if user_signed_in?
      redirect_back fallback_location: api_movies_path unless correct_user
    else
      redirect_back fallback_location: api_movies_path
    end
  end

  # Devise-jwt
  include ActionController::MimeResponds

  respond_to :jsonapi

  def render_jsonapi_response(resource)
    if resource.errors.empty?
      render jsonapi: resource
    else
      render jsonapi_errors: resource.errors, status: 400
    end
  end
end
