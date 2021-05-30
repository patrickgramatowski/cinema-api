module Api
  class HallsController < ApplicationController
    include JSONAPI::Fetching
    # HTTP GET list of halls
    def index
      render jsonapi: Halls::UseCases::FetchAll.new.call
    end

    # HTTP GET hall by id
    def show
      render jsonapi: Halls::UseCases::FetchOne.new.call(id: params[:id])
    end

    # HTTP POST create hall
    def create
      @hall = Halls::UseCases::Create.new.call(params: hall_params)

      if @hall.valid?
        render jsonapi: @hall, status: :created
      else
        render json: @hall.errors, status: :unprocessable_entity
      end
    end

    # HTTP PUT update the halls params
    def update
      @hall = Halls::UseCases::Update.new.call(id: params[:id], params: hall_params)

      if @hall.valid?
        render jsonapi: @hall
      else
        render json: @hall.errors, status: :unprocessable_entity
      end
    end

    # HTTP DELETE destroy the hall
    def destroy
      Halls::UseCases::Delete.new.call(id: params[:id])
    end

    private

    def hall_params
      params.require(:hall).permit(:hall, :seats)
    end
  end
end
