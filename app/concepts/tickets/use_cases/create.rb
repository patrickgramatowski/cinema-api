module Tickets
  module UseCases
    class Create < ::UseCases::BaseCreate
      attr_reader :repository

      def initialize(repository: Tickets::Repository.new)
        super(repository: repository)
      end
    end
  end
end
