# frozen_string_literal: true

module TicketDesks
  module UseCases
    class FetchAll < ::UseCases::BaseFetchAll
      attr_reader :repository

      def initialize(repository: TicketDesks::Repository.new)
        super(repository: repository)
      end
    end
  end
end
