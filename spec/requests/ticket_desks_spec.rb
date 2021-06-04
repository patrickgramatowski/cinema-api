require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "TicketDesks requests" do
  describe "GET /api/ticket_desks" do
    let!(:ticket_desk) { build(:ticket_desk) }

    it "works and return status 200" do
      get("/api/ticket_desks")
      expect(response.status).to eq(200)
    end
  end

  resource "ticket_desks" do
    get("/api/ticket_desks") do
      example "Gets list of ticket_desks" do
        do_request
        
        expect(status).to eq(200)
      end
    end
  end

  describe "GET /api/ticket_desks/:id" do
    let!(:ticket_desk) { build(:ticket_desk) }

    it "works and return status 200" do
      get("/api/ticket_desks/#{ticket_desk.id}")
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/ticket_desks" do
    it "works and return status 201" do
      post("/api/ticket_desks", params: { ticket_desk: {  online: true } } )
      expect(response.status).to eq(201)
    end
  end

  describe "POST /api/ticket_desks" do
    it "does not work and return status 422" do
      post("/api/ticket_desks", params: { ticket_desk: {  ticket_desk: "ticket_desk_2" } } )
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/ticket_desks/:id' do
    let!(:ticket_desk) { create(:ticket_desk) }

    it 'works and returns status 200' do
      put("/api/ticket_desks/#{ticket_desk.id}", params: { ticket_desk: { id: ticket_desk.id, name: "ticket_desk_updated" } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /api/ticket_desks/:id' do
    let!(:ticket_desk) { create(:ticket_desk) }

    it 'works and return status 204' do
      delete("/api/ticket_desks/#{ticket_desk.id}")
      expect(response.status).to eq(204)
    end
  end
end
