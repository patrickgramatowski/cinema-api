require "rails_helper"

RSpec.describe Seances::UseCases::AvailableSeats do
  describe ".call" do
    let!(:hall) { create :hall, id: 1, seats: 100 }
    let(:instance) { described_class.new }
    let!(:seance) { create(:seance, id: 222, hall_id: hall.id) }
    let!(:reservation) { create(:reservation, id: 181, status: "paid", seance_id: seance.id) }
    let!(:ticket) { create(:ticket, seat: "5C", reservation_id: reservation.id) }

    it "shows available seats" do
      expect(instance.call(id: seance.id)[:seats]).to include("1A")
    end

    it "shows not available seats" do
      expect(instance.call(id: seance.id)[:taken_seats].first).to eql(ticket.seat)
    end
  end
end