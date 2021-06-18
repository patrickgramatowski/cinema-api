# frozen_string_literal: true

module Reservations
  module UseCases
    class Create
      attr_reader :repository, :params, :user

      def initialize(params:, user:, repository: Reservations::Repository.new)
        @repository = repository
        @params = params
        @user = user
      end

      def call
        ActiveRecord::Base.transaction do
          repository.create!(reservation_params).tap do |reservation|
            Tickets::UseCases::Create.new(reservation: reservation, tickets: params[:tickets]).call
            cancel_expired(reservation: reservation)
          end
        end
      end

      private

      def reservation_params
        {
          seance_id: params[:seance_id],
          ticket_desk_id: params[:ticket_desk_id],
          status: "paid",
          user_id: user # todo seed - abstarct user
        }
      end

      def cancel_expired(reservation:)
        cancel_date = reservation.seance.time_before_seance
        CancelReservationWorker.perform_at(cancel_date, reservation.id)
      end
    end
  end
end
