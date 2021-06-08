# frozen_string_literal: true

module Halls
  module UseCases
    class Delete < ::UseCases::BaseDelete
      attr_reader :repository

      def initialize(repository: Halls::Repository.new)
        super(repository: repository)
      end
    end
  end
end
