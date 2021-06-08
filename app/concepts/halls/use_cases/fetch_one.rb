# frozen_string_literal: true

module Halls
  module UseCases
    class FetchOne < ::UseCases::BaseFetchOne
      attr_reader :repository

      def initialize(repository: Halls::Repository.new)
        super(repository: repository)
      end
    end
  end
end
