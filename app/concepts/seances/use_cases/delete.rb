# frozen_string_literal: true

module Seances
  module UseCases
    class Delete < ::UseCases::BaseDelete
      attr_reader :repository

      def initialize(repository: Seances::Repository.new)
        super(repository: repository)
      end
    end
  end
end
