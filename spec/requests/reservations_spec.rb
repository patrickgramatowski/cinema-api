require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Reservations requests", type: :request do
  let(:user_1) { create(:user, id: 1, email: "testtest@wp.pl", password: "testtest", employee: false )}
  let(:user_2) { create(:user, id: 2, email: "testtest2@wp.pl", password: "testtest", employee: true )}
  let!(:user_3) { create(:user, id: 999, email: "testtest3@wp.pl", password: "testtest", employee: false )}

  describe "GET /api/reservations" do
    let!(:reservation) { build(:reservation) }

    context "when user is logged in" do
      it "redirects if user is not employee" do
        get("/api/reservations", headers: setup_request(user_1))
        expect(response.status).to eq(302)
      end

      it "works if user is employee" do
        get("/api/reservations", headers: setup_request(user_2))
        expect(response.status).to eq(200)
      end
    end

    context "when user is not logged in" do
      it "works if user is employee" do
        get("/api/reservations")
        expect(response.status).to eq(302)
      end
    end
  end

  describe "GET /api/reservations/:id" do
    let!(:reservation) { build(:reservation) }

    context "when user is logged in" do
      it "redirects if user is not employee" do
        get("/api/reservations/#{reservation.id}", headers: setup_request(user_1))
        expect(response.status).to eq(302)
      end

      it "works if user is not employee" do
        get("/api/reservations/#{reservation.id}", headers: setup_request(user_2))
        expect(response.status).to eq(200)
      end
    end

    context "when user is not logged in" do
      it "redirects" do
        get("/api/reservations/#{reservation.id}")
        expect(response.status).to eq(302)
      end 
    end
  end

  describe "GET /api/reservations/ushow/:id" do
    let(:reservation) { create(:reservation, user_id: user_1.id) }
    let(:user_test) { create(:user, employee: false) }

    context "when user is logged in" do
      it "shows user's reservation" do
        get("/api/reservations/ushow/#{reservation.id}", headers: setup_request(user_1))
        expect(response.status).to eq(200)
      end

      it "does not show the reservation to other users" do
        get("/api/reservations/ushow/#{reservation.id}", headers: setup_request(user_test))
        expect(response.status).to eq(302)
      end
    end

    context "when user is not logged in" do
      it "does not show the reservation to other users" do
        get("/api/reservations/ushow/#{reservation.id}")
        expect(response.status).to eq(401)
      end
    end
  end

  describe "GET /api/reservations/uindex" do
    let!(:reservation_a) { create(:reservation, user_id: user_1.id) }
    let!(:reservation_b) { create(:reservation, user_id: user_1.id) }
    let!(:reservation_c) { create(:reservation, user_id: user_1.id) }
    let(:user_test) { create(:user, employee: false) }

    context "when user is logged in" do
      it "works and returns list of reservations for specific user" do
        get("/api/reservations/uindex", headers: setup_request(user_1))
        expect(response.status).to eq(200)
        expect(response.body).to include(reservation_a.id.to_s, reservation_b.id.to_s, reservation_c.id.to_s)
      end

      it "returns empty list if user has no reservations" do
        get("/api/reservations/uindex", headers: setup_request(user_test))
        expect(response.status).to eq(200)
        expect(response.body).to include("{\"data\":[]}")
      end
    end

    context "when user is not logged in" do
      it "returns 401" do
        get("/api/reservations/uindex")
        expect(response.status).to eq(401)
      end
    end
  end

  describe "POST /api/reservations/online" do
    let(:seance) { create(:seance, id: 101) }
    let!(:ticket_desk) { create(:ticket_desk, id: 101, online: true) }

    context "when user is logged in" do
      it "works if user is not meployee" do
          post("/api/reservations/online", headers: setup_request(user_1), params: { seance_id: seance.id, status: "paid" , tickets: [{ seat: '8A', ticket_type: "normal", price: 22 }] }.to_json)
          expect(response.status).to eq(201)
      end

      it "works if user is employee" do
        post("/api/reservations/online", headers: setup_request(user_2), params: { seance_id: seance.id, status: "paid" , tickets: [{ seat: '9A', ticket_type: "normal", price: 22 }] }.to_json)
        expect(response.status).to eq(201)
      end
    end

    context "when user is not logged in" do
      it "returns 401" do
        post("/api/reservations/online", params: { seance_id: seance.id, status: "paid" , tickets: [{ seat: '10A', ticket_type: "normal", price: 22 }] }.to_json)
        expect(response.status).to eq(401)
      end
    end
  end

  describe "POST /api/reservations/offline" do
    let(:seance) { create(:seance, id: 102) }
    let(:ticket_desk) { create(:ticket_desk, id: 102) }

    context "when user is logged in" do
      it "works and returns status 201" do
        post("/api/reservations/offline", headers: setup_request(user_2), params: { seance_id: seance.id, status: "pending", ticket_desk_id: ticket_desk.id, tickets: [{ seat: '5C', ticket_type: "normal", price: 22 }] }.to_json)
        expect(response.status).to eq(201)
      end

      it "redirects if user is not employee" do
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

    context "when user is not logged in" do
      it "redirects" do
        put("/api/reservations/#{reservation.id}", params: { reservation: { id: reservation.id, status: "paid" } }.to_json)
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'DELETE /api/reservations/:id' do
    let!(:reservation) { create(:reservation) }

    context "when user is logged in" do
      it 'works and returns status 204 if user is employee' do
        delete("/api/reservations/#{reservation.id}", headers: setup_request(user_2))
        expect(response.status).to eq(204)
      end

      it 'redirects if user is not employee' do
        delete("/api/reservations/#{reservation.id}", headers: setup_request(user_1))
        expect(response.status).to eq(302)
      end
    end

    context "when user is not logged in" do
      it 'redirects' do
        delete("/api/reservations/#{reservation.id}")
        expect(response.status).to eq(302)
      end
    end
  end
end