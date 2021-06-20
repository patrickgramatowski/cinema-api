require "rails_helper"

RSpec.describe Reservations::UseCases::FetchOneForUser do
  describe ".call" do
    let(:user) { create(:user, id: 11) }
    let(:user_2) { create(:user, id: 22) }

    let!(:reservation_1) { create(:reservation, user_id: user.id) }
    let!(:reservation_2) { create(:reservation, user_id: user.id) }
    let!(:reservation_3) { create(:reservation, user_id: user_2.id) }

    let(:instance) { described_class.new(user: user, reservation_id: reservation_1.id) }
    let(:instance_2) { described_class.new(user: user_2, reservation_id: reservation_3.id) }
    let(:instance_3) { described_class.new(user: user, reservation_id: reservation_3.id) }


    it "shows the reservation" do
      expect(instance.call.count).to eql(1)
      expect(instance.call.first).to eql(reservation_1)
    end

    context "when reservation created by another user" do
      it "doesn't show reservations not related to the user" do
        expect(instance_3.call.count).to eql(0)
      end

      it "shows the reservation only for the related user" do
        expect(instance_2.call.count).to eql(1)
        expect(instance_2.call.first).to eql(reservation_3)
      end
    end
  end
end