module Seances
  module UseCases
    class FetchOne < ::UseCases::BaseFetchOne
      attr_reader :repository

      def initialize(repository: Seances::Repository.new)
        super(repository: repository)
      end
    end
  end
end
