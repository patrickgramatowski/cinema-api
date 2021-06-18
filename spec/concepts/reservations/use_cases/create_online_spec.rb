require "rails_helper"

RSpec.describe Reservations::UseCases::CreateOnline do
  describe ".call" do
    let!(:ticket_desk) { create(:ticket_desk) }
    let(:seance) { create(:seance, id: 78)}
    let(:params) { { seance_id: seance.id, tickets: [{ seat: "5D", price: 21, ticket_type: "normal" }] } }
    let(:user) { create(:user, id: 11) }
    let(:instance) { described_class.new(params: params, user: user.id) }

    it "creates reservation" do
      expect { instance.call }.to change { Reservation.count }.by(1)
    end

    it "creates reservation" do
      expect { instance.call }.to change { Reservation.count }.from(0).to(1)
    end

    it "returns reservation" do
      expect(instance.call).to be_a_kind_of(Reservation)
    end
  end
end