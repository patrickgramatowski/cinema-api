# frozen_string_literal: true

module Tickets
  module UseCases
    class Delete < ::UseCases::BaseDelete
      attr_reader :repository

      def initialize(repository: Tickets::Repository.new)
        super(repository: repository)
      end
    end
  end
end
