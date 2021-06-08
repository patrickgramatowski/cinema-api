# frozen_string_literal: true

module Tickets
  module UseCases
    class FetchAll < ::UseCases::BaseFetchAll
      attr_reader :repository

      def initialize(repository: Tickets::Repository.new)
        super(repository: repository)
      end
    end
  end
end
