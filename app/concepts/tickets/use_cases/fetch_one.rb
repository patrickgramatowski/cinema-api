module Tickets
  module UseCases
    class FetchOne < ::UseCases::BaseFetchOne
      attr_reader :repository

      def initialize(repository: Tickets::Repository.new)
        super(repository: repository)
      end
    end
  end
end
