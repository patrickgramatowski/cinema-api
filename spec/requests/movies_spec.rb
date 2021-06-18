require "rails_helper"
require "rspec_api_documentation/dsl"
require "devise/jwt/test_helpers"

RSpec.describe "Movies requests" do
  let(:user_1) { create(:user, employee: false) }
  let(:user_2) { create(:user, employee: true) }

  describe "GET /api/movies" do
    let!(:movie) { build(:movie) }

    it "works and return status 200" do
      get("/api/movies", headers: setup_request(user_1))
      expect(response.status).to eq(200)
    end
  end

  resource "Movies" do
    get("/api/movies") do
      example "Gets list of movies" do
        do_request
        
        expect(status).to eq(401)
      end
    end
  end

  describe "GET /api/movies/:id" do
    let!(:movie) { build(:movie) }

    it "works and return status 200" do
      get("/api/movies/#{movie.id}", headers: setup_request(user_1))
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/movies" do
    it "works and return status 201" do
      post("/api/movies", headers: setup_request(user_2), params: { movie: {  title: "Movie_9", genre: "Comedy", length: 110 } }.to_json )
      expect(response.status).to eq(201)
    end

    it "redirects and return status 302" do
      post("/api/movies", headers: setup_request(user_1), params: { movie: {  title: "Movie_9", genre: "Comedy", length: 110 } }.to_json )
      expect(response.status).to eq(302)
    end
  end

  describe "POST /api/movies" do
    it "does not work and return status 422" do
      post("/api/movies", headers: setup_request(user_2), params: { movie: {  title: "Movie_4" } }.to_json )
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/movies/:id' do
    let!(:movie) { create(:movie) }

    it 'works and returns status 200' do
      put("/api/movies/#{movie.id}", headers: setup_request(user_2), params: { movie: { id: movie.id, title: "Movie_updated" } }.to_json)
      expect(response.status).to eq(200)
    end

    it "redirects and return status 302" do
      put("/api/movies/#{movie.id}", headers: setup_request(user_1), params: { movie: { id: movie.id, title: "Movie_updated" } }.to_json)
      expect(response.status).to eq(302)
    end
  end

  describe 'DELETE /api/movies/:id' do
    let!(:movie) { create(:movie) }

    it 'works and return status 204' do
      delete("/api/movies/#{movie.id}", headers: setup_request(user_2))
      expect(response.status).to eq(204)
    end

    it "redirects and return status 302" do
      delete("/api/movies/#{movie.id}", headers: setup_request(user_1))
      expect(response.status).to eq(302)
    end    
  end
end

private

def setup_request(user)
  headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
end
