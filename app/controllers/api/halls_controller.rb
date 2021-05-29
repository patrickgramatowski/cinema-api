module Api
  class HallsController < ApplicationController
    include JSONAPI::Fetching
    # HTTP GET list of halls
    def index
      render jsonapi: Halls.all
    end
  end
end
