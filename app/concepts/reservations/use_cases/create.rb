module Reservations
  module UseCases
    class Create < ::UseCases::BaseCreate
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        super(repository: repository)
      end
    end
  end
end
