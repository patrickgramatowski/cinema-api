module Reservations
  module UseCases
    class FetchOne < ::UseCases::BaseFetchOne
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        super(repository: repository)
      end
    end
  end
end
