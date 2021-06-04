module Tickets
  module UseCases
    class Update < ::UseCases::BaseUpdate
      attr_reader :repository

      def initialize(repository: Tickets::Repository.new)
        super(repository: repository)
      end
    end
  end
end
