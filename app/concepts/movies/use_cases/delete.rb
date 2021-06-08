# frozen_string_literal: true

module Movies
  module UseCases
    class Delete < ::UseCases::BaseDelete
      attr_reader :repository

      def initialize(repository: Movies::Repository.new)
        super(repository: repository)
      end
    end
  end
end
