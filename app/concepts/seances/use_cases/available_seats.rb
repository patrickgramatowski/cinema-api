# frozen_string_literal: true

module Seances
  module UseCases
    class AvailableSeats
      attr_reader :repository

      def initialize(repository: Seances::Repository.new)
        @repository = repository
      end

      def call(id:)
        seance = repository.find(id)
        taken_seats = seance.reservations.where(status: "paid").or(seance.reservations.where(status: "pending")).flat_map(&:tickets).map(&:seat)
        all_seats = Halls::UseCases::GenerateSeats.new.call(hall_id: seance.hall_id)
        available_seats = all_seats - taken_seats
        { movie: seance.movie, hall: seance.hall, seats: available_seats, taken_seats: taken_seats }.to_json
      end
    end
  end
end
