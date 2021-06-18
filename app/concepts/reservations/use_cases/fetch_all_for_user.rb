# frozen_string_literal: true

module Reservations
  module UseCases
    class FetchAllForUser
      attr_reader :repository, :user_id

      def initialize(user_id:, repository: Reservations::Repository.new)
        @repository = repository
        @user_id = user_id
      end

      def call
        repository.adapter.where(user_id: user_id).all
      end
    end
  end
end
