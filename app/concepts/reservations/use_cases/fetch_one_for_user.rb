# frozen_string_literal: true

module Reservations
  module UseCases
    class FetchOneForUser
      attr_reader :repository, :reservation_id, :user

      def initialize(user:, reservation_id:, repository: Reservations::Repository.new)
        @repository = repository
        @reservation_id = reservation_id
        @user = user
      end

      def call
        User.find(user.id).reservations.where(id: reservation_id)
      end
    end
  end
end
