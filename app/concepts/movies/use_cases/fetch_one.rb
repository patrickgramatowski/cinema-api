module Movies
  module UseCases
    class FetchOne < ::UseCases::BaseFetchOne
      attr_reader :repository

      def initialize(repository: Movies::Repository.new)
        super(repository: repository)
      end
    end
  end
end
