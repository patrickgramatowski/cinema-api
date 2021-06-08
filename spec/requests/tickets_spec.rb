require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Tickets requests" do
  let(:ticket_desk) { create(:ticket_desk).id }
  let(:reservation) { create(:reservation).id }

  before do
    ticket_desk
    reservation
  end

  describe "GET /api/ticket_desks/:id/reservations/:id/tickets" do
    let!(:ticket) { build(:ticket) }

    it "works and return status 200" do
      get("/api/ticket_desks/#{ticket_desk}/reservations/#{reservation}/tickets")
      expect(response.status).to eq(200)
    end
  end

  resource "tickets" do
    get("/api/ticket_desks/1/reservations/1/tickets") do
      example "Gets list of tickets" do
        do_request
        
        expect(status).to eq(200)
      end
    end
  end

  describe "GET /api/ticket_desks/:id/reservations/:id/tickets/:id" do
    let!(:ticket) { build(:ticket) }

    it "works and return status 200" do
      get("/api/ticket_desks/#{ticket_desk}/reservations/#{reservation}/tickets/#{ticket.id}")
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/ticket_desks/:id/reservations/:id/tickets" do
    let(:reservation) { create(:reservation) }

    it "works and return status 201" do
      post("/api/ticket_desks/#{ticket_desk}/reservations/#{reservation.id}/tickets", params: { ticket: { price: 22, ticket_type: "Normal", seat: "1A", reservation_id: reservation.id  } } )
      expect(response.status).to eq(201)
    end
  end

  describe "POST /api/ticket_desks/:id/reservations/:id/tickets" do
    it "does not work and return status 422" do
      post("/api/ticket_desks/#{ticket_desk}/reservations/#{reservation}/tickets", params: { ticket: { price: 11 } } )
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/ticket_desks/:id/reservations/:id/tickets/:id' do
    let!(:ticket) { create(:ticket) }

    it 'works and returns status 200' do
      put("/api/ticket_desks/#{ticket_desk}/reservations/#{reservation}/tickets/#{ticket.id}", params: { ticket: { price: 111 } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /api/ticket_desks/:id/reservations/:id/tickets/:id' do
    let!(:ticket) { create(:ticket) }

    it 'works and return status 204' do
      delete("/api/ticket_desks/#{ticket_desk}/reservations/#{reservation}/tickets/#{ticket.id}")
      expect(response.status).to eq(204)
    end
  end
end
