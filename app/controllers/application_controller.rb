# frozen_string_literal: true

class ApplicationController < ActionController::API
  # JSON API modules
  include JSONAPI::Fetching
  include JSONAPI::Errors
end
