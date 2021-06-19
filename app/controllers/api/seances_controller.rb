# frozen_string_literal: true

module Api
  class SeancesController < ApplicationController
    before_action :check_permission, except: %i[show index]


    # HTTP GET list of seances
    def index
      render jsonapi: Seances::UseCases::FetchAll.new.call
    end

    # HTTP GET seance by id
    def show
      render json: Seances::UseCases::AvailableSeats.new.call(id: params[:id])
    end

    # HTTP POST create seance
    def create
      @seance = Seances::UseCases::Create.new.call(params: seance_params)

      if @seance.valid?
        render jsonapi: @seance, status: :created
      else
        render jsonapi_errors: @seance.errors, status: :unprocessable_entity
      end
    end

    # HTTP PUT update the halls seance
    def update
      @seance = Seances::UseCases::Update.new.call(id: params[:id], params: seance_params)

      if @seance.valid?
        render jsonapi: @seance
      else
        render jsonapi_errors: @seance.errors, status: :unprocessable_entity
      end
    end

    # HTTP DELETE destroy the seance
    def destroy
      Seances::UseCases::Delete.new.call(id: params[:id])
    end

    private

    def seance_params
      params.require(:seance).permit(:date, :time, :movie_id, :hall_id)
    end
  end
end
