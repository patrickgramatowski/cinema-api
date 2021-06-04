module TicketDesks
  module UseCases
    class Update < ::UseCases::BaseUpdate
      attr_reader :repository

      def initialize(repository: TicketDesks::Repository.new)
        super(repository: repository)
      end
    end
  end
end
