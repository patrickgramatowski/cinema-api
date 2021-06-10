require "rails_helper"

RSpec.describe Halls::UseCases::Update do
  describe ".call" do
    let!(:hall) { create :hall, id: 77, hall: "Hall test", seats: 101 }
    let(:params) do
      {
        hall: "Hall updated",
        seats: 99
      }
    end
    let(:instance) { described_class.new }

    it "updates hall name" do
      expect { instance.call(id: 77, params: params) }
        .to change { hall.reload.hall }.from("Hall test").to("Hall updated")
    end

    it "updates hall seats" do
      expect { instance.call(id: 77,params: params) }
        .to change { hall.reload.seats }.from(101).to(99)
    end

    it "updates hall attributes" do
      expect { instance.call(id: 77, params: params) }
        .to change { hall.reload.seats }.from(101).to(99)
        .and change { hall.reload.hall }.from("Hall test").to("Hall updated")
    end

    it "returns hall" do
      expect(instance.call(id: 77, params: params)).to eq(hall)
    end
  end
end