# frozen_string_literal: true

module Halls
  module UseCases
    class GenerateSeats
      attr_reader :repository

      def initialize(repository: Halls::Repository.new)
        @repository = repository
      end

      def call(hall_id:)
        seats = repository.find(hall_id).seats
        (1..seats / 10).to_a.product(('A'..'Z').take(seats / 10)).map(&:join)
      end
    end
  end
end
