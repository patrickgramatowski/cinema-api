module Halls
  module UseCases
    class FetchOne
      attr_reader :repository

      def initialize(repository: Halls::Repository.new)
        @repository = repository
      end

      def call(id:)
        repository.find(id)
      end
    end
  end
end
