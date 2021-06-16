require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Tickets requests" do
  let(:reservation) { create(:reservation).id }

  before do
    reservation
  end

  describe "GET /api/reservations/:id/tickets" do
    let!(:ticket) { build(:ticket) }

    it "works and return status 200" do
      get("/api/reservations/#{reservation}/tickets")
      expect(response.status).to eq(200)
    end
  end

  resource "tickets" do
    get("/api/reservations/1/tickets") do
      example "Gets list of tickets" do
        do_request
        
        expect(status).to eq(200)
      end
    end
  end

  describe "GET /api/reservations/:id/tickets/:id" do
    let!(:ticket) { build(:ticket) }

    it "works and return status 200" do
      get("/api/reservations/#{reservation}/tickets/#{ticket.id}")
      expect(response.status).to eq(200)
    end
  end
end
