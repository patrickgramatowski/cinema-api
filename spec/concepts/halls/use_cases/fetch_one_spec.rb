require "rails_helper"

RSpec.describe Halls::UseCases::FetchOne do
  describe ".call" do
    let!(:hall) { create :hall, id: 1 }
    let!(:hall_2) { create :hall, id: 2 }
    let!(:hall_3) { create :hall, id: 3 }
    let(:instance) { described_class.new }

    it "fetches one hall records" do
      expect(instance.call(id: 2)).to eql(Hall.find_by(id: hall_2.id))
    end
  end
end