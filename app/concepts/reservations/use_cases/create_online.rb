# frozen_string_literal: true

module Reservations
  module UseCases
    class CreateOnline
      attr_reader :repository, :params, :user

      def initialize(params:, user:, repository: Reservations::Repository.new)
        @repository = repository
        @params = params
        @user = user
      end

      def call
        ActiveRecord::Base.transaction do
          repository.create!(reservation_params).tap do |reservation|
            Tickets::UseCases::Create.new(reservation: reservation, tickets: ticket_params(params[:tickets])).call
            cancel_expired(reservation: reservation)
            archive(reservation: reservation)
          end
        end
      end

      private

      def reservation_params
        {
          seance_id: params[:seance_id],
          ticket_desk_id: TicketDesk.where(online: true).first.id,
          status: "pending",
          user_id: user
        }
      end

      def ticket_params(tickets)
        tickets_list = []
        tickets.map do |ticket|
          tickets_list << {
            seat: ticket[:seat],
            ticket_type: ticket[:ticket_type],
            price: 22 # todo
          }
        end
        tickets_list
      end

      def cancel_expired(reservation:)
        cancel_date = reservation.seance.time_before_seance
        CancelReservationWorker.perform_at(cancel_date, reservation.id)
      end

      def archive(reservation:)
        archive_date = reservation.seance.date
        ArchiveReservationWorker.perform_at(archive_date, reservation.id)
      end
    end
  end
end
