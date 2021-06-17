# frozen_string_literal: true

class ApplicationController < ActionController::API
  # JSON API modules
  include JSONAPI::Fetching
  include JSONAPI::Errors

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
