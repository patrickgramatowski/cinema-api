# frozen_string_literal: true

module Reservations
  module UseCases
    class FetchOneForUser
      attr_reader :repository, :user_id, :reservation_id

      def initialize(user_id:, reservation_id:, repository: Reservations::Repository.new)
        @repository = repository
        @user_id = user_id
        @reservation_id = reservation_id
      end

      def call
        repository.adapter.where("user_id = :user_id and id = :id", { user_id: user_id, id: reservation_id })
      end
    end
  end
end
