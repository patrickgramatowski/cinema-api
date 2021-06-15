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

  describe "POST /api/reservations/:id/tickets" do
    let(:reservation) { create(:reservation) }

    it "works and return status 201" do
      post("/api/reservations/#{reservation.id}/tickets", params: { ticket: { price: 22, ticket_type: "Normal", seat: "1A", reservation_id: reservation.id  } } )
      expect(response.status).to eq(201)
    end
  end

  describe "POST /api/reservations/:id/tickets" do
    it "does not work and return status 422" do
      post("/api/reservations/#{reservation}/tickets", params: { ticket: { price: 11 } } )
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/reservations/:id/tickets/:id' do
    let!(:ticket) { create(:ticket) }

    it 'works and returns status 200' do
      put("/api/reservations/#{reservation}/tickets/#{ticket.id}", params: { ticket: { price: 111 } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /api/reservations/:id/tickets/:id' do
    let!(:ticket) { create(:ticket) }

    it 'works and return status 204' do
      delete("/api/reservations/#{reservation}/tickets/#{ticket.id}")
      expect(response.status).to eq(204)
    end
  end
end
