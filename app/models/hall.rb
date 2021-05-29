class Hall < ApplicationRecord
  validates :hall, presence: true
  validates :seats, presence: true
end
