require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Seances requests", type: :request do
  let(:user_1) { create(:user, employee: false) }
  let(:user_2) { create(:user, employee: true) }

  describe "GET /api/seances" do
    let!(:seance) { build(:seance) }

    context "when user logged in" do
      it "works and returns status 200" do
        get("/api/seances", headers: setup_request(user_1))
        expect(response.status).to eq(200)
      end

      it "works and returns status 200" do
        get("/api/seances", headers: setup_request(user_2))
        expect(response.status).to eq(200)
      end
    end

    context "when user not logged in" do
      it "works and returns status 200" do
        get("/api/seances")
        expect(response.status).to eq(200)
      end
    end
  end

  describe "GET /api/seances/:id" do
    let!(:seance) { build(:seance) }

    context "when user logged in" do
      it "works and returns status 200" do
        get("/api/seances/#{seance.id}", headers: setup_request(user_1))
        expect(response.status).to eq(200)
      end

      it "works and returns status 200" do
        get("/api/seances/#{seance.id}", headers: setup_request(user_2))
        expect(response.status).to eq(200)
      end
    end

    context "when user not logged in" do
      it "works and returns status 200" do
        get("/api/seances/#{seance.id}")
        expect(response.status).to eq(200)
      end
    end
  end

  describe "POST /api/seances" do
    let(:movie) { create(:movie).id }
    let(:hall) { create(:hall).id }

    context "when user logged in" do
      it "works and returns status 201" do
        post("/api/seances", headers: setup_request(user_2), params: { seance: { date: "2021-05-31", time: "17:00", movie_id: movie, hall_id: hall } }.to_json )
        expect(response.status).to eq(201)
      end

      it "redirects and returns status 302" do
        post("/api/seances", headers: setup_request(user_1), params: { seance: { date: "2021-05-31", time: "17:00", movie_id: movie, hall_id: hall } }.to_json )
        expect(response.status).to eq(302)
      end
    end

    context "when user not logged in" do
      it "redirects and returns status 302" do
        post("/api/seances", params: { seance: { date: "2021-05-31", time: "17:00", movie_id: movie, hall_id: hall } }.to_json )
        expect(response.status).to eq(302)
      end
    end
  end

  describe "POST /api/seances" do
    it "does not work and returns status 422" do
      post("/api/seances", headers: setup_request(user_2), params: { seance: {  time: "18:00" } }.to_json )
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/seances/:id' do
    let!(:seance) { create(:seance) }

    context "when user logged in" do
      it 'works and returnss status 200' do
        put("/api/seances/#{seance.id}", headers: setup_request(user_2), params: { seance: { id: seance.id, time: "19:00" } }.to_json)
        expect(response.status).to eq(200)
      end

      it "redirects and returns status 302" do
        put("/api/seances/#{seance.id}", headers: setup_request(user_1), params: { seance: { id: seance.id, time: "19:00" } }.to_json)
        expect(response.status).to eq(302)
      end
    end

    context "when user not logged in" do
      it "redirects and returns status 302" do
        put("/api/seances/#{seance.id}", params: { seance: { id: seance.id, time: "19:00" } }.to_json)
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'DELETE /api/seances/:id' do
    let!(:seance) { create(:seance) }

    context "when user logged in" do
      it 'works and returns status 204' do
        delete("/api/seances/#{seance.id}", headers: setup_request(user_2))
        expect(response.status).to eq(204)
      end

      it 'redirects and returns status 302' do
        delete("/api/seances/#{seance.id}", headers: setup_request(user_1))
        expect(response.status).to eq(302)
      end
    end

    context "when use not logged in" do
      it 'redirects and returns status 302' do
        delete("/api/seances/#{seance.id}", headers: setup_request(user_1))
        expect(response.status).to eq(302)
      end
    end
  end
end
