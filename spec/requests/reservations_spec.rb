require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Reservations requests" do
  describe "GET /api/reservations" do
    let!(:reservation) { build(:reservation) }

    it "works and return status 200" do
      get("/api/reservations")
      expect(response.status).to eq(200)
    end
  end

  resource "Reservations" do
    get("/api/reservations") do
      example "Gets list of reservations" do
        do_request
        
        expect(status).to eq(200)
      end
    end
  end

  describe "GET /api/reservations/:id" do
    let!(:reservation) { build(:reservation) }

    it "works and return status 200" do
      get("/api/reservations/#{reservation.id}")
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/reservations/online" do
    let(:seance) { create(:seance, id: 101) }
    let(:ticket_desk) { create(:ticket_desk, id: 101) }
    it "works and return status 201" do
      post("/api/reservations/online", params: { seance_id: seance.id, status: "paid" , tickets: [{ seat: '8A', ticket_type: "normal", price: 22 }] })
      expect(response.status).to eq(201)
    end
  end

  describe "POST /api/reservations/offline" do
    let(:seance) { create(:seance, id: 102) }
    let(:ticket_desk) { create(:ticket_desk, id: 102) }
    it "works and return status 201" do
      post("/api/reservations/offline", params: { seance_id: seance.id, status: "pending", ticket_desk_id: ticket_desk.id, tickets: [{ seat: '5C', ticket_type: "normal", price: 22 }] })
      expect(response.status).to eq(201)
    end
  end

  describe "POST /api/reservations/online" do
    let(:seance) { create(:seance, id: 103) }
    let(:ticket_desk) { create(:ticket_desk, id: 103) }
    let(:reservation) { create(:reservation, seance_id: seance.id) }
    let!(:ticket) { create(:ticket, reservation_id: reservation.id, seat: "5C")}
    let(:request) { 
      post("/api/reservations/online", params: { seance_id: seance.id, status: "pending", ticket_desk_id: ticket_desk.id, tickets: [{ seat: '5C', ticket_type: "normal", price: 33 }] })
    }
    it "does not work and return status 422" do
      expect { request }.to raise_error(Tickets::UseCases::Create::SeatsNotAvailableError)
    end
  end

  describe 'PUT /api/reservations/:id' do
    let!(:reservation) { create(:reservation) }

    it 'works and returns status 200' do
      put("/api/reservations/#{reservation.id}", params: { reservation: { id: reservation.id, status: "paid" } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /api/reservations/:id' do
    let!(:reservation) { create(:reservation) }

    it 'works and return status 204' do
      delete("/api/reservations/#{reservation.id}")
      expect(response.status).to eq(204)
    end
  end
end
