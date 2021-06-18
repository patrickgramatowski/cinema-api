require "rails_helper"

RSpec.describe Reservations::UseCases::FetchAllForUser do
  describe ".call" do
    let(:user) { create(:user, id: 11) }
    let(:user_2) { create(:user, id: 22) }

    let!(:reservation_1) { create(:reservation, user_id: user.id) }
    let!(:reservation_2) { create(:reservation, user_id: user.id) }
    let!(:reservation_3) { create(:reservation, user_id: user_2.id) }

    let(:instance) { described_class.new(user_id: user.id) }
    let(:instance_2) { described_class.new(user_id: user_2.id) }

    it "shows users reservations" do
      expect(instance.call.count).to eql(2)
    end

    context "when reservation created by another user" do
      it "shows the reservation only for the related user" do
        expect(instance_2.call.count).to eql(1)
      end
    end
  end
end