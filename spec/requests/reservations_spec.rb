require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Reservations requests" do
  let(:ticket_desk) { create(:ticket_desk).id }

  before do
    ticket_desk
  end

  describe "POST /api/reservations" do
    let!(:seance) { create(:seance).id }

    it "works and return status 201" do
      post("/api/reservations", params: { reservation: { id: 12, seance_id: seance, status: "pending", ticket_desk_id: ticket_desk, seats: "A1,A2", tickets_attributes: [{ seat: "A1", ticket_type: "Normal", price: 12 }, { seat: "A2", ticket_type: "Normal", price: 22 }] } })
      expect(response.status).to eq(201)
    end
  end

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

  describe "GET api/reservations/:id" do
    let!(:reservation) { build(:reservation) }

    it "works and return status 200" do
      get("/api/reservations/#{reservation.id}")
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/reservations" do
    let!(:seance) { create(:seance).id }
    it "works and return status 201" do
      post("/api/reservations", params: { reservation: { seance_id: seance, status: "pending", ticket_desk_id: ticket_desk, seats: "A1,A2" } })
      expect(response.status).to eq(201)
    end
  end

  describe "POST /api/reservations" do
    it "does not work and return status 422" do
      post("/api/reservations", params: { reservation: { seance_id: nil } } )
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/reservations/:id' do
    let!(:reservation) { create(:reservation) }
    let!(:seance) { create(:seance) }

    it 'works and returns status 200' do
      put("/api/reservations/#{reservation.id}", params: { reservation: { id: reservation.id, seance_id: seance.id } })
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
