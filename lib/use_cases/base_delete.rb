# frozen_string_literal: true

module UseCases
  class BaseDelete
    attr_reader :repository

    def initialize(repository:)
      @repository = repository
    end

    def call(id:)
      repository.delete(id)
    end
  end
end
