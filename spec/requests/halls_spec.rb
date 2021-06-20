require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Halls requests", type: :request do
  let(:user_1) { create(:user, employee: false) }
  let(:user_2) { create(:user, employee: true) }

  describe "GET /api/halls" do
    let!(:hall) { build(:hall) }

    context "when user is logged in" do
      it "works if use is employee" do
        get("/api/halls", headers: setup_request(user_2))
        expect(response.status).to eq(200)
      end

      it "redirects if user is not employee" do
        get("/api/halls", headers: setup_request(user_1))
        expect(response.status).to eq(302)
      end
    end

    context "when user is not logged in" do
      it "redirects" do
        get("/api/halls")
        expect(response.status).to eq(302)
      end
    end
  end

  describe "GET /api/halls/:id" do
    let!(:hall) { build(:hall) }

    context "when user is logged in" do
      it "works if user is employee" do
        get("/api/halls/#{hall.id}", headers: setup_request(user_2))
        expect(response.status).to eq(200)
      end

      it "redirects if user is not employee" do
        get("/api/halls/#{hall.id}", headers: setup_request(user_1))
        expect(response.status).to eq(302)
      end
    end

    context "when user is not logged in" do
      it "redirects" do
        get("/api/halls/#{hall.id}")
        expect(response.status).to eq(302)
      end
    end
  end

  describe "POST /api/halls" do
    context "when user is logged in" do
      it "works if user is employee" do
        post("/api/halls", headers: setup_request(user_2), params: { hall: {  hall: "Hall_2", seats: 150 } }.to_json )
        expect(response.status).to eq(201)
      end

      it "redirects if user is not employee" do
        post("/api/halls", headers: setup_request(user_1), params: { hall: {  hall: "Hall_2", seats: 150 } }.to_json )
        expect(response.status).to eq(302)
      end
    end

    context "when user is not logged in" do
      it "redirects if user is not employee" do
        post("/api/halls", params: { hall: {  hall: "Hall_2", seats: 150 } }.to_json )
        expect(response.status).to eq(302)
      end
    end
  end

  describe "POST /api/halls" do
    it "does not work and return status 422" do
      post("/api/halls", headers: setup_request(user_2), params: { hall: {  hall: "Hall_2" } }.to_json )
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/halls/:id' do
    let!(:hall) { create(:hall) }

    context "when user is logged in" do
      it "works if user is employee" do
        put("/api/halls/#{hall.id}", headers: setup_request(user_2), params: { hall: { id: hall.id, name: "Hall_updated" } }.to_json)
        expect(response.status).to eq(200)
      end

      it "redirects if user is not employee" do
        put("/api/halls/#{hall.id}", headers: setup_request(user_1), params: { hall: { id: hall.id, name: "Hall_updated" } }.to_json)
        expect(response.status).to eq(302)
      end
    end

    context "when user is not logged in" do
      it "redirects" do
        put("/api/halls/#{hall.id}", params: { hall: { id: hall.id, name: "Hall_updated" } }.to_json)
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'DELETE /api/halls/:id' do
    let!(:hall) { create(:hall) }

    context "when user is logged in" do
      it 'works if user is employee' do
        delete("/api/halls/#{hall.id}", headers: setup_request(user_2))
        expect(response.status).to eq(204)
      end

      it 'redirects if user is not employee' do
        delete("/api/halls/#{hall.id}", headers: setup_request(user_1))
        expect(response.status).to eq(302)
      end
    end

    context "when user is not logged in" do
      it 'redirects' do
        delete("/api/halls/#{hall.id}")
        expect(response.status).to eq(302)
      end
    end
  end
end
