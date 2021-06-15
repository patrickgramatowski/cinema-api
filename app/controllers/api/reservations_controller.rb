# frozen_string_literal: true

module Api
  class ReservationsController < ApplicationController
    # HTTP GET list of reservations
    def index
      render jsonapi: Reservations::UseCases::FetchAll.new.call
    end

    # HTTP GET reservation by id
    def show
      render jsonapi: Reservations::UseCases::FetchOne.new.call(id: params[:id])
    end

    # HTTP POST create reservation online
    def create
      @reservation = Reservations::UseCases::Create.new.call(params: reservation_params)
      check_if_valid(@reservation)
    end

    # HTTP POST create reservation offline
    def create_offline
      @reservation = Reservations::UseCases::CreateOffline.new.call(params: reservation_params)
      check_if_valid(@reservation)
      puts @reservation.status
    end

    # HTTP PUT update the halls reservation
    def update
      @reservation = Reservations::UseCases::Update.new.call(id: params[:id], params: reservation_params)

      if @reservation.valid?
        render jsonapi: @reservation
      else
        render jsonapi_errors: @reservation.errors, status: :unprocessable_entity
      end
    end

    # HTTP DELETE destroy the reservation
    def destroy
      Reservations::UseCases::Delete.new.call(id: params[:id])
    end

    private

    def check_if_valid(reservation)
      if reservation.valid?
        render jsonapi: reservation, status: :created
      else
        render jsonapi_errors: reservation.errors, status: :unprocessable_entity
      end
    end

    def reservation_params
      params.require(:reservation).permit(:seance_id, :ticket_desk_id, :status, :seats)
    end
  end
end
