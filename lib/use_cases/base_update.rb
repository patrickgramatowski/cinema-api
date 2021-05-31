module UseCases
  class BaseUpdate
    attr_reader :repository

    def initialize(repository:)
      @repository = repository
    end

    def call(id:, params:)
      repository.update(id, params)
    end
  end
end
