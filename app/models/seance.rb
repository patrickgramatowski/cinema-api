class Seance < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
end
