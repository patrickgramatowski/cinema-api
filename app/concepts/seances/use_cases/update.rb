# frozen_string_literal: true

module Seances
  module UseCases
    class Update < ::UseCases::BaseUpdate
      attr_reader :repository

      def initialize(repository: Seances::Repository.new)
        super(repository: repository)
      end
    end
  end
end
