# frozen_string_literal: true

module Seances
  class Repository < ::BaseRepository
    def initialize(adapter: Seance)
      super(adapter: adapter)
    end
  end
end
