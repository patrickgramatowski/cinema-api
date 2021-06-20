# frozen_string_literal: true

module Reservations
  module UseCases
    class FetchAllForUser
      attr_reader :repository, :user

      def initialize(user:, repository: Reservations::Repository.new)
        @repository = repository
        @user = user
      end

      def call
        User.find(user.id).reservations
      end
    end
  end
end
