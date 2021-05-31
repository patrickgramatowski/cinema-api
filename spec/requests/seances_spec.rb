require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Seances requests" do
  describe "GET /api/seances" do
    let!(:seance) { build(:seance) }

    it "works and return status 200" do
      get("/api/seances")
      expect(response.status).to eq(200)
    end
  end

  resource "Halls" do
    get("/api/seances") do
      example "Gets list of seances" do
        do_request
        
        expect(status).to eq(200)
      end
    end
  end

  describe "GET /api/seances/:id" do
    let!(:seance) { build(:seance) }

    it "works and return status 200" do
      get("/api/seances/#{seance.id}")
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/seances" do
    let(:movie) { create(:movie).id }
    let(:hall) { create(:hall).id }

    it "works and return status 201" do
      post("/api/seances", params: { seance: {  date: "2021-05-31", time: "17:00", movie_id: movie, hall_id: hall } } )
      expect(response.status).to eq(201)
    end
  end

  describe "POST /api/seances" do
    it "does not work and return status 422" do
      post("/api/seances", params: { seance: {  time: "18:00" } } )
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/seances/:id' do
    let!(:seance) { create(:seance) }

    it 'works and returns status 200' do
      put("/api/seances/#{seance.id}", params: { seance: { id: seance.id, time: "19:00" } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /api/seances/:id' do
    let!(:seance) { create(:seance) }

    it 'works and return status 204' do
      delete("/api/seances/#{seance.id}")
      expect(response.status).to eq(204)
    end
  end
end
