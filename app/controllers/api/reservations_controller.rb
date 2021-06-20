# frozen_string_literal: true

module Api
  class ReservationsController < ApplicationController
    before_action :authenticate_user!, only: %i[user_index user_show create_online]
    before_action :check_permission, except: %i[user_index user_show create_online]

    # HTTP GET list of reservations
    def index
      render jsonapi: Reservations::UseCases::FetchAll.new.call
    end

    def user_index
      render jsonapi: Reservations::UseCases::FetchAllForUser.new(user: current_user).call
    end

    def user_show
      reservation = Reservations::UseCases::FetchOneForUser.new(user: current_user, reservation_id: params[:id]).call
      if reservation.empty?
        redirect_back fallback_location: api_movies_path
      else
        render jsonapi: reservation
      end
    end

    # HTTP GET reservation by id
    def show
      render jsonapi: Reservations::UseCases::FetchOne.new.call(id: params[:id])
    end

    # HTTP POST create reservation offline
    def create
      @reservation = Reservations::UseCases::Create.new(params: offline_params, user: current_user.id).call
      check_if_valid(@reservation)
    end

    # HTTP POST create reservation online
    def create_online
      @reservation = Reservations::UseCases::CreateOnline.new(params: online_params, user: current_user.id).call
      ReservationMailer.reservation_information(current_user.email, @reservation).deliver_now
      check_if_valid(@reservation)
    end

    # HTTP PUT update reservation
    def update
      @reservation = Reservations::UseCases::Update.new.call(id: params[:id], params: update_params)

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
    rescue Tickets::UseCases::Create::SeatsNotAvailableError => e
      render jsonapi_errors: e.message, status: :unprocessable_entity
    end

    def update_params
      params.require(:reservation).permit(:status)
    end

    def online_params
      params.permit(:seance_id, tickets: %i[seat ticket_type])
    end

    def offline_params
      params.permit(:seance_id, :ticket_desk_id, :status, tickets: %i[seat price ticket_type])
    end
  end
end
