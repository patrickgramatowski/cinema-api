# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  ActionDispatch::Response.default_headers = {
    'X-Frame-Options' => 'SAMEORIGIN',
    'X-Content-Type-Options' => 'nosniff',
    'X-XSS-Protection' => '0'
  }

  protect_from_forgery

  # JSON API modules
  include JSONAPI::Fetching
  include JSONAPI::Errors
end
