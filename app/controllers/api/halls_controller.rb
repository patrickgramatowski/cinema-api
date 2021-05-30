module Api
  class HallsController < ApplicationController
    include JSONAPI::Fetching
    # HTTP GET list of halls
    def index
      render jsonapi: Hall.all
    end
  end
end
