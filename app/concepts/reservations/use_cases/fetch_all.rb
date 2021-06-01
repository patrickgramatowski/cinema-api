module Reservations
  module UseCases
    class FetchAll < ::UseCases::BaseFetchAll
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        super(repository: repository)
      end
    end
  end
end
