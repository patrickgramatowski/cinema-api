require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.describe "Tickets requests" do
  let(:ticket_desk) { create(:ticket_desk).id }
  let(:reservation) { create(:reservation).id }

  before do
    ticket_desk
    reservation
  end

  describe "GET /api//tickets" do
    let!(:ticket) { build(:ticket) }

    it "works and return status 200" do
      get("/api/tickets")
      expect(response.status).to eq(200)
    end
  end

  resource "tickets" do
    get("/api/tickets") do
      example "Gets list of tickets" do
        do_request
        
        expect(status).to eq(200)
      end
    end
  end

  describe "GET /api/tickets/:id" do
    let!(:ticket) { build(:ticket) }

    it "works and return status 200" do
      get("/api/tickets/#{ticket.id}")
      expect(response.status).to eq(200)
    end
  end
end


=begin

  describe "POST /api/tickets" do
    let(:reservation) { create(:reservation) }

    it "works and return status 201" do
      post("/api/tickets", params: { ticket: { price: 22, ticket_type: "Normal", seat: "1A", reservation_id: reservation.id  } } )
      expect(response.status).to eq(201)
    end
  end

  describe "POST /api/tickets" do
    it "does not work and return status 422" do
      post("/api/tickets", params: { ticket: { price: 11 } } )
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT /api/tickets/:id' do
    let!(:ticket) { create(:ticket) }

    it 'works and returns status 200' do
      put("/api/tickets/#{ticket.id}", params: { ticket: { price: 111 } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /api/tickets/:id' do
    let!(:ticket) { create(:ticket) }

    it 'works and return status 204' do
      delete("/api/tickets/#{ticket.id}")
      expect(response.status).to eq(204)
    end
  end

=end