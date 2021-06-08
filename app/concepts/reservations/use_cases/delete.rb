# frozen_string_literal: true

module Reservations
  module UseCases
    class Delete < ::UseCases::BaseDelete
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        super(repository: repository)
      end
    end
  end
end
