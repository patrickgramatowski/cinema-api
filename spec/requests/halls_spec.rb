RSpec.describe "Halls requests" do
  describe "GET /api/halls" do
    let!(:hall) { build(:hall) }

    it "works and return status 200" do
      get("/api/halls")
      expect(response.status).to eq(200)
    end
  end
end