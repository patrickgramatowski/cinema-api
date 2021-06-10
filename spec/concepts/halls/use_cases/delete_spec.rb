require "rails_helper"

RSpec.describe Halls::UseCases::Delete do
  describe ".call" do
    let!(:hall) { create :hall }
    let(:instance) { described_class.new }

    it "deletes hall record" do
      expect { instance.call(id: hall.id) }.to change { Hall.count }.by(-1)
    end

    it "deletes hall record" do
      instance.call(id: hall.id)
      expect(Hall.find_by(id: hall.id)).to eq(nil)
    end
  end
end