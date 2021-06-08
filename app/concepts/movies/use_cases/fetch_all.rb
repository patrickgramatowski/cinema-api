# frozen_string_literal: true

module Movies
  module UseCases
    class FetchAll < ::UseCases::BaseFetchAll
      attr_reader :repository

      def initialize(repository: Movies::Repository.new)
        super(repository: repository)
      end
    end
  end
end
