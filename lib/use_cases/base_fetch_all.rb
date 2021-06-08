# frozen_string_literal: true

module UseCases
  class BaseFetchAll
    attr_reader :repository

    def initialize(repository:)
      @repository = repository
    end

    def call
      repository.find_all
    end
  end
end
