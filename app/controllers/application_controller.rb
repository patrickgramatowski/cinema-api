# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JSONAPI::Fetching
  include JSONAPI::Errors
end
