require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Halls requests", type: :request do
  let(:user_1) { create(:user, employee: false) }
  let(:user_2) { create(:user, employee: true) }

  describe "GET /api/halls" do
    let!(:hall) { build(:hall) }

    it "works and return status 200" do
      get("/api/halls", headers: setup_request(user_2))
      expect(response.status).to eq(200)
    end

    it "redirects and return status 302" do
      get("/api/halls", headers: setup_request(user_1))
      expect(response.status).to eq(302)
    end
  end

  describe "GET /api/halls/:id" do
    let!(:hall) { build(:hall) }

    it "works and return status 200" do
      get("/api/halls/#{hall.id}", headers: setup_request(user_2))
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/halls" do
    it "works and return status 201" do
      post("/api/halls", headers: setup_request(user_2), params: { hall: {  hall: "Hall_2", seats: 150 } }.to_json )
      expect(response.status).to eq(201)
    end

    it "redirects and return status 302" do
      post("/api/halls", headers: setup_request(user_1), params: { hall: {  hall: "Hall_2", seats: 150 } }.to_json )
      expect(response.status).to eq(302)
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

    it 'works and returns status 200' do
      put("/api/halls/#{hall.id}", headers: setup_request(user_2), params: { hall: { id: hall.id, name: "Hall_updated" } }.to_json)
      expect(response.status).to eq(200)
    end

    it "redirects and return status 302" do
      put("/api/halls/#{hall.id}", headers: setup_request(user_1), params: { hall: { id: hall.id, name: "Hall_updated" } }.to_json)
      expect(response.status).to eq(302)
    end
    
  end

  describe 'DELETE /api/halls/:id' do
    let!(:hall) { create(:hall) }

    it 'works and return status 204' do
      delete("/api/halls/#{hall.id}", headers: setup_request(user_2))
      expect(response.status).to eq(204)
    end
  end
end
