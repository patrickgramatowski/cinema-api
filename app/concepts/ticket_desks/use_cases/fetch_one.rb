module TicketDesks
  module UseCases
    class FetchOne < ::UseCases::BaseFetchOne
      attr_reader :repository

      def initialize(repository: TicketDesks::Repository.new)
        super(repository: repository)
      end
    end
  end
end
