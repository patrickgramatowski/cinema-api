require "rails_helper"

RSpec.describe Halls::UseCases::GenerateSeats do
  describe ".call" do
    let!(:hall) { create :hall, id: 1, seats: 100 }
    let(:instance) { described_class.new }

    it "generates seats for a hall" do
      expect(instance.call(hall_id: 1).count).to eql(hall.seats)
    end
  end
end