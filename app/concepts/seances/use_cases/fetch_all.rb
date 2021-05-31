module Seances
  module UseCases
    class FetchAll < ::UseCases::BaseFetchAll
      attr_reader :repository

      def initialize(repository: Seances::Repository.new)
        super(repository: repository)
      end
    end
  end
end
