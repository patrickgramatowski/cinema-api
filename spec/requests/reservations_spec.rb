require "rails_helper"
require "rspec_api_documentation/dsl"
require "devise/jwt/test_helpers"

RSpec.describe "Reservations requests" do
  let(:user_1) { create(:user, id: 1, email: "testtest@wp.pl", password: "testtest", employee: false )}
  let(:user_2) { create(:user, id: 2, email: "testtest2@wp.pl", password: "testtest", employee: true )}

  describe "GET /api/reservations" do
    let!(:reservation) { build(:reservation) }

    it "doesnt work for not employee" do
      get("/api/reservations", headers: setup_request(user_1))
      expect(response.status).to eq(302)
    end
  end

  describe "GET /api/reservations/:id" do
    let!(:reservation) { build(:reservation) }

    it "redirects" do
      get("/api/reservations/#{reservation.id}", headers: setup_request(user_1))
      expect(response.status).to eq(302)
    end
  end

  describe "GET /api/reservations/ushow/:id" do
    let!(:reservation) { build(:reservation) }

    it "works and returns 200" do
      get("/api/reservations/ushow/#{reservation.id}", headers: setup_request(user_1))
      expect(response.status).to eq(200)
    end
  end

  describe "GET /api/reservations/uindex" do
    let!(:reservation) { build(:reservation) }

    it "works and returns 200" do
      get("/api/reservations/uindex", headers: setup_request(user_1))
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/reservations/online" do
    let(:seance) { create(:seance, id: 101) }
    let!(:ticket_desk) { create(:ticket_desk, id: 101, online: true) }
    it "works and return status 201" do
      post("/api/reservations/online", headers: setup_request(user_1), params: { seance_id: seance.id, status: "paid" , tickets: [{ seat: '8A', ticket_type: "normal", price: 22 }] }.to_json)
      expect(response.status).to eq(201)
    end
  end

  describe "POST /api/reservations/offline" do
    let(:seance) { create(:seance, id: 102) }
    let(:ticket_desk) { create(:ticket_desk, id: 102) }
    it "works and return status 201" do
      post("/api/reservations/offline", headers: setup_request(user_2), params: { seance_id: seance.id, status: "pending", ticket_desk_id: ticket_desk.id, tickets: [{ seat: '5C', ticket_type: "normal", price: 22 }] }.to_json)
      expect(response.status).to eq(201)
    end

    context "when user is not employee" do
      it "works and return status 302" do
        post("/api/reservations/offline", headers: setup_request(user_1), params: { seance_id: seance.id, status: "pending", ticket_desk_id: ticket_desk.id, tickets: [{ seat: '5C', ticket_type: "normal", price: 22 }] }.to_json)
        expect(response.status).to eq(302)
      end
    end
  end

  describe "POST /api/reservations/online" do
    let(:seance) { create(:seance, id: 103) }
    let(:ticket_desk) { create(:ticket_desk, id: 103) }
    let(:reservation) { create(:reservation, seance_id: seance.id) }
    let!(:ticket) { create(:ticket, reservation_id: reservation.id, seat: "5C")}
    let(:request) { 
      post("/api/reservations/online", headers: setup_request(user_1), params: { seance_id: seance.id, status: "pending", ticket_desk_id: ticket_desk.id, tickets: [{ seat: '5C', ticket_type: "normal", price: 33 }] }.to_json)
    }
    it "when seat is taken returns error" do
      expect { request }.to raise_error(Tickets::UseCases::Create::SeatsNotAvailableError)
    end
  end

  describe 'PUT /api/reservations/:id' do
    let!(:reservation) { create(:reservation) }

    context "when user is not employee" do
      it 'works and returns status 302' do
        put("/api/reservations/#{reservation.id}", headers: setup_request(user_1), params: { reservation: { id: reservation.id, status: "paid" } }.to_json)
        expect(response.status).to eq(302)
      end
    end

    context "when user is an employee" do
      it "works and return status 200" do
        put("/api/reservations/#{reservation.id}", headers: setup_request(user_2), params: { reservation: { id: reservation.id, status: "paid" } }.to_json)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'DELETE /api/reservations/:id' do
    let!(:reservation) { create(:reservation) }

    it 'works and return status 204' do
      delete("/api/reservations/#{reservation.id}", headers: setup_request(user_2))
      expect(response.status).to eq(204)
    end
  end
end

private

def setup_request(user)
  headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
end
