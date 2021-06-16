# frozen_string_literal: true

module Reservations
  module UseCases
    class CreateOffline < ::UseCases::BaseCreate
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        super(repository: repository)
      end

      def call(params:)
        params[:status] = "paid"
        repository.create(params)
      end
    end
  end
end
