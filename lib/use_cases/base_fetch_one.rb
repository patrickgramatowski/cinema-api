# frozen_string_literal: true

module UseCases
  class BaseFetchOne
    attr_reader :repository

    def initialize(repository:)
      @repository = repository
    end

    def call(id:)
      repository.find(id)
    end
  end
end
