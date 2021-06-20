require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Movies requests", type: :request do
  let(:user_1) { create(:user, employee: false) }
  let(:user_2) { create(:user, employee: true) }

  describe "GET /api/movies" do
    let!(:movie) { build(:movie) }

    context "when user is logged in" do
      it "works and return status 200" do
        get("/api/movies", headers: setup_request(user_1))
        expect(response.status).to eq(200)
      end

      it "works and return status 200" do
        get("/api/movies", headers: setup_request(user_2))
        expect(response.status).to eq(200)
      end
    end

    context "when user is not logged in" do
      it "works and return status 200" do
        get("/api/movies")
        expect(response.status).to eq(200)
      end
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

    context "when user is logged in" do
      it "works and return status 200" do
        get("/api/movies/#{movie.id}", headers: setup_request(user_1))
        expect(response.status).to eq(200)
      end

      it "works and return status 200" do
        get("/api/movies/#{movie.id}", headers: setup_request(user_2))
        expect(response.status).to eq(200)
      end
    end

    context "when user is not logged in" do
      it "works and return status 200" do
        get("/api/movies/#{movie.id}")
        expect(response.status).to eq(200)
      end
    end
  end

  describe "POST /api/movies" do
    context "when user is logged in" do
      it "works if user is employee" do
        post("/api/movies", headers: setup_request(user_2), params: { movie: {  title: "Movie_9", genre: "Comedy", length: 110 } }.to_json )
        expect(response.status).to eq(201)
      end

      it "redirects if user is not employee" do
        post("/api/movies", headers: setup_request(user_1), params: { movie: {  title: "Movie_9", genre: "Comedy", length: 110 } }.to_json )
        expect(response.status).to eq(302)
      end
    end

    context "when user is not logged in" do
      it "redirects" do
        post("/api/movies", params: { movie: {  title: "Movie_9", genre: "Comedy", length: 110 } }.to_json )
        expect(response.status).to eq(302)
      end
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

    context "when user is logged in" do
      it 'works if user is employee' do
        put("/api/movies/#{movie.id}", headers: setup_request(user_2), params: { movie: { id: movie.id, title: "Movie_updated" } }.to_json)
        expect(response.status).to eq(200)
      end

      it "redirects if user is not employee" do
        put("/api/movies/#{movie.id}", headers: setup_request(user_1), params: { movie: { id: movie.id, title: "Movie_updated" } }.to_json)
        expect(response.status).to eq(302)
      end
    end

    context "when user is not logged in" do
      it "redirects" do
        put("/api/movies/#{movie.id}", params: { movie: { id: movie.id, title: "Movie_updated" } }.to_json)
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'DELETE /api/movies/:id' do
    let!(:movie) { create(:movie) }

    context "when user is logged in" do
      it 'works if user is employee' do
        delete("/api/movies/#{movie.id}", headers: setup_request(user_2))
        expect(response.status).to eq(204)
      end

      it "redirects if user is not employee" do
        delete("/api/movies/#{movie.id}", headers: setup_request(user_1))
        expect(response.status).to eq(302)
      end
    end

    context "when user is not logged in" do
      it "redirects" do
        delete("/api/movies/#{movie.id}")
        expect(response.status).to eq(302)
      end
    end
  end
end
