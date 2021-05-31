module Halls
  module UseCases
    class Update < ::UseCases::BaseUpdate
      attr_reader :repository

      def initialize(repository: Halls::Repository.new)
        super(repository: repository)
      end
    end
  end
end
