require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Reservations requests" do
  let(:ticket_desk) { create(:ticket_desk).id }

  before do
    ticket_desk
  end

  describe "GET /api/ticket_desks/:id/reservations" do
    let!(:reservation) { build(:reservation) }

    it "works and return status 200" do
      get("/api/ticket_desks/#{ticket_desk}/reservations")
      expect(response.status).to eq(200)
    end
  end

  resource "Reservations" do
    get("/api/ticket_desks/1/reservations") do
      example "Gets list of reservations" do
        do_request
        
        expect(status).to eq(200)
      end
    end
  end

  describe "GET /api/ticket_desks/:id/reservations/:id" do
    let!(:reservation) { build(:reservation) }

    it "works and return status 200" do
      get("/api/ticket_desks/#{ticket_desk}/reservations/#{reservation.id}")
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/ticket_desks/:id/reservations" do
    let!(:seance) { create(:seance).id }
    it "works and return status 201" do
      post("/api/ticket_desks/#{ticket_desk}/reservations", params: { reservation: { seance_id: seance, status: "Paid", ticket_desk_id: ticket_desk, seats: "A1,A2" } })
      expect(response.status).to eq(201)
    end
  end

  describe "POST /api/ticket_desks/:id/reservations" do
    it "does not work and return status 422" do
      post("/api/ticket_desks/#{ticket_desk}/reservations", params: { reservation: { seance_id: nil } } )
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/ticket_desks/:id/reservations/:id' do
    let!(:reservation) { create(:reservation) }
    let!(:seance) { create(:seance) }

    it 'works and returns status 200' do
      put("/api/ticket_desks/#{ticket_desk}/reservations/#{reservation.id}", params: { reservation: { id: reservation.id, seance_id: seance.id } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /api/ticket_desks/:id/reservations/:id' do
    let!(:reservation) { create(:reservation) }

    it 'works and return status 204' do
      delete("/api/ticket_desks/#{ticket_desk}/reservations/#{reservation.id}")
      expect(response.status).to eq(204)
    end
  end
end
