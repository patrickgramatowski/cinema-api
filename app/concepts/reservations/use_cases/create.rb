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
          end
        end
      end

      private

      def reservation_params
        {
          seance_id: params[:seance_id],
          ticket_desk_id: params[:ticket_desk_id],
          status: "paid",
          user_id: 999 # add reservations created offline to an abstract user - id: 999
        }
      end
    end
  end
end
