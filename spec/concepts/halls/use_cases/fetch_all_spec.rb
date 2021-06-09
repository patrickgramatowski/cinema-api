require "rails_helper"

RSpec.describe Halls::UseCases::FetchAll do
  describe ".call" do
    let!(:hall) { create :hall }
    let!(:hall_1) { create :hall }
    let!(:hall_2) { create :hall }
    let(:instance) { described_class.new }

    it "fetches all hall records" do
      expect(instance.call.count).to eql(Hall.count)
    end

    it "fetches all hall records with their attributes" do
      expect(instance.call.last).to eql(Hall.last)
    end
  end
end