# frozen_string_literal: true

module Tickets
  module UseCases
    class Create
      SeatsNotAvailableError = Class.new(StandardError)
      attr_reader :reservation, :tickets

      def initialize(reservation:, tickets:)
        @reservation = reservation
        @tickets = tickets
      end

      def call
        tickets.map do |ticket|
          raise SeatsNotAvailableError unless available_seats.include? ticket[:seat]

          reservation.tickets.create(ticket)
        end
      end

      private

      def available_seats
        Seances::UseCases::AvailableSeats.new.call(id: reservation.seance_id)[:seats]
      end
    end
  end
end
