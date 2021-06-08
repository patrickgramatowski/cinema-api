# frozen_string_literal: true

class Hall < ApplicationRecord
  has_many :seances

  validates :hall, presence: true
  validates :seats, presence: true
end
