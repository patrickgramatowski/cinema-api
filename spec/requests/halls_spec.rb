require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Halls requests" do
  describe "GET /api/halls" do
    let!(:hall) { build(:hall) }

    it "works and return status 200" do
      get("/api/halls")
      expect(response.status).to eq(200)
    end
  end

  resource "Halls" do
    get("/api/halls") do
      example "Gets list of halls" do
        do_request
        
        expect(status).to eq(200)
      end
    end
  end

  describe "GET /api/halls/:id" do
    let!(:hall) { build(:hall) }

    it "works and return status 200" do
      get("/api/halls/#{hall.id}")
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/halls" do
    it "works and return status 201" do
      post("/api/halls", params: { hall: {  hall: "Hall_2", seats: 150 } } )
      expect(response.status).to eq(201)
    end
  end

  describe "POST /api/halls" do
    it "does not work and return status 422" do
      post("/api/halls", params: { hall: {  hall: "Hall_2" } } )
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/halls/:id' do
    let!(:hall) { create(:hall) }

    it 'works and returns status 200' do
      put("/api/halls/#{hall.id}", params: { hall: { id: hall.id, name: "Hall_updated" } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /api/halls/:id' do
    let!(:hall) { create(:hall) }

    it 'works and return status 204' do
      delete("/api/halls/#{hall.id}")
      expect(response.status).to eq(204)
    end
  end
end
