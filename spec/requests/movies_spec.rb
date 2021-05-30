require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Movies requests" do
  describe "GET /api/movies" do
    let!(:movie) { build(:movie) }

    it "works and return status 200" do
      get("/api/movies")
      expect(response.status).to eq(200)
    end
  end

  resource "Movies" do
    get("/api/movies") do
      example "Gets list of movies" do
        do_request
        
        expect(status).to eq(200)
      end
    end
  end

  describe "GET /api/movies/:id" do
    let!(:movie) { build(:movie) }

    it "works and return status 200" do
      get("/api/movies/#{movie.id}")
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/movies" do
    it "works and return status 201" do
      post("/api/movies", params: { movie: {  title: "Movie_9", genre: "Comedy", length: 110 } } )
      expect(response.status).to eq(201)
    end
  end

  describe "POST /api/movies" do
    it "does not work and return status 422" do
      post("/api/movies", params: { movie: {  title: "Movie_4" } } )
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/movies/:id' do
    let!(:movie) { create(:movie) }

    it 'works and returns status 200' do
      put("/api/movies/#{movie.id}", params: { movie: { id: movie.id, title: "Movie_updated" } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /api/movies/:id' do
    let!(:movie) { create(:movie) }

    it 'works and return status 204' do
      delete("/api/movies/#{movie.id}")
      expect(response.status).to eq(204)
    end
  end
end
