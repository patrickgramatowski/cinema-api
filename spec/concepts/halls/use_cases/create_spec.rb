require "rails_helper"

RSpec.describe Halls::UseCases::Create do
  describe ".call" do
    let(:params) do 
      {
        hall: "Hall Test",
        seats: 100
      }
    end
    let(:instance) { described_class.new }

    it "creates hall record" do
      expect { instance.call(params: params) }.to change { Hall.count }.by(1)
    end

    it "creates hall record" do
      expect { instance.call(params: params) }.to change { Hall.count }.from(0).to(1)
    end

    it "returns hall" do
      expect(instance.call(params: params)).to be_a_kind_of(Hall)
    end

    it "returns hall with proper attributes" do
      expect(instance.call(params: params)).to have_attributes(params)
    end
  end
end