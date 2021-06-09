require "rails_helper"

RSpec.describe Halls::Repository do
  describe ".find_all" do
    let(:instance) { described_class.new }
    let!(:hall_1) { create :hall }
    let!(:hall_2) { create :hall }
    let!(:hall_3) { create :hall }
    let!(:hall_4) { create :hall }
    let!(:hall_5) { create :hall }

    it "returns one hall" do
      expect(instance.find_all).to eq([hall_1, hall_2, hall_3, hall_4, hall_5])
    end
  end
end