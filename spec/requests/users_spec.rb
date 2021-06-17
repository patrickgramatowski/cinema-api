require "rails_helper"

describe Api::UsersController, type: :request do

  let (:user) { create(:user) }

  context 'When fetching a user' do
    before do
      login_with_api(user)
      get "/api/users/#{user.id}", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the user' do
      expect(json['data']["id"]).to include(user.id.to_s)
    end
  end

  context 'When a user is missing' do
    before do
      login_with_api(user)
      get "/api/users/blank", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 404' do
      expect(response.status).to eq(404)
    end
  end

  context 'When the Authorization header is missing' do
    before do
      get "/api/users/#{user.id}"
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end
  end
end

private

def json
  JSON.parse(response.body)
end

def login_with_api(user)
  post '/api/login', params: {
    user: {
      email: user.email,
      password: user.password
    }
  }
end