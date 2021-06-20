require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Tickets requests", type: :request do
  let(:reservation) { create(:reservation).id }
  let(:user_1) { create(:user, employee: false) }
  let(:user_2) { create(:user, employee: true) }

  before do
    reservation
  end

  describe "GET /api/reservations/:id/tickets" do
    let!(:ticket) { build(:ticket) }

    it "works and return status 200" do
      get("/api/reservations/#{reservation}/tickets", headers: setup_request(user_2))
      expect(response.status).to eq(200)
    end

    it "redirects and returns 302" do
      get("/api/reservations/#{reservation}/tickets", headers: setup_request(user_1))
      expect(response.status).to eq(302)
    end
  end

  describe "GET /api/reservations/:id/tickets/:id" do
    let!(:ticket) { build(:ticket) }

    it "works and return status 200" do
      get("/api/reservations/#{reservation}/tickets/#{ticket.id}", headers: setup_request(user_2))
      expect(response.status).to eq(200)
    end

    it "redirects returns 302" do
      get("/api/reservations/#{reservation}/tickets/#{ticket.id}", headers: setup_request(user_1))
      expect(response.status).to eq(302)
    end
  end
end
