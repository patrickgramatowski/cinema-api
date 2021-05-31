module Seances
  module UseCases
    class Create < ::UseCases::BaseCreate
      attr_reader :repository

      def initialize(repository: Seances::Repository.new)
        super(repository: repository)
      end
    end
  end
end
