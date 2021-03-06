require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "TicketDesks requests", type: :request do
  let(:user_1) { create(:user, employee: false) }
  let(:user_2) { create(:user, employee: true) }

  describe "GET /api/ticket_desks" do
    let!(:ticket_desk) { build(:ticket_desk) }

    context "when user logged in" do
      it "works and return status 200" do
        get("/api/ticket_desks", headers: setup_request(user_2))
        expect(response.status).to eq(200)
      end

      it "redirects returns 302" do
        get("/api/ticket_desks", headers: setup_request(user_1))
        expect(response.status).to eq(302)
      end
    end

    context "when user not logged in" do
      it "redirects returns 302" do
        get("/api/ticket_desks")
        expect(response.status).to eq(302)
      end
    end
  end

  describe "GET /api/ticket_desks/:id" do
    let!(:ticket_desk) { build(:ticket_desk) }

    context "when user logged in" do
      it "works and return status 200" do
        get("/api/ticket_desks/#{ticket_desk.id}", headers: setup_request(user_2))
        expect(response.status).to eq(200)
      end

      it "redirects returns 302" do
        get("/api/ticket_desks/#{ticket_desk.id}", headers: setup_request(user_1))
        expect(response.status).to eq(302)
      end
    end

    context "when user not logged in" do
      it "redirects returns 302" do
        get("/api/ticket_desks/#{ticket_desk.id}")
        expect(response.status).to eq(302)
      end
    end
  end

  describe "POST /api/ticket_desks" do
    context "when user logged in" do
      it "works and return status 201" do
        post("/api/ticket_desks", headers: setup_request(user_2), params: { ticket_desk: {  online: true } }.to_json )
        expect(response.status).to eq(201)
      end

      it "redirects returns 302" do
        post("/api/ticket_desks", headers: setup_request(user_1), params: { ticket_desk: {  online: true } }.to_json )
        expect(response.status).to eq(302)
      end
    end

    context "when user not logged in" do
      it "redirects returns 302" do
        post("/api/ticket_desks", params: { ticket_desk: {  online: true } }.to_json )
        expect(response.status).to eq(302)
      end
    end
  end

  describe "POST /api/ticket_desks" do
    it "does not work and return status 422" do
      post("/api/ticket_desks", headers: setup_request(user_2), params: { ticket_desk: {  ticket_desk: "ticket_desk_2" } }.to_json )
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/ticket_desks/:id' do
    let!(:ticket_desk) { create(:ticket_desk) }

    context "when user logged in" do
      it 'works and returns status 200' do
        put("/api/ticket_desks/#{ticket_desk.id}", headers: setup_request(user_2), params: { ticket_desk: { id: ticket_desk.id, name: "ticket_desk_updated" } }.to_json)
        expect(response.status).to eq(200)
      end

      it "redirects returns 302" do
        put("/api/ticket_desks/#{ticket_desk.id}", headers: setup_request(user_1), params: { ticket_desk: { id: ticket_desk.id, name: "ticket_desk_updated" } }.to_json)
        expect(response.status).to eq(302)
      end
    end

    context "when user not logged in" do
      it "redirects returns 302" do
        put("/api/ticket_desks/#{ticket_desk.id}", params: { ticket_desk: { id: ticket_desk.id, name: "ticket_desk_updated" } }.to_json)
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'DELETE /api/ticket_desks/:id' do
    let!(:ticket_desk) { create(:ticket_desk) }

    context "when user logged in" do
      it 'works and return status 204' do
        delete("/api/ticket_desks/#{ticket_desk.id}", headers: setup_request(user_2))
        expect(response.status).to eq(204)
      end

      it "redirects returns 302" do
        delete("/api/ticket_desks/#{ticket_desk.id}", headers: setup_request(user_1))
        expect(response.status).to eq(302)
      end
    end

    context "when user not logged in" do
      it "redirects returns 302" do
        delete("/api/ticket_desks/#{ticket_desk.id}")
        expect(response.status).to eq(302)
      end
    end
  end
end
