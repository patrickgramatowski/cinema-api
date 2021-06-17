# frozen_string_literal: true

class ApplicationController < ActionController::API
  # JSON API modules
  include JSONAPI::Fetching
  include JSONAPI::Errors

  # Devise-jwt
  include ActionController::MimeResponds

  respond_to :jsonapi
end
