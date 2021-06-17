require 'rails_helper'

describe RegistrationsController, type: :request do

  let (:user) { build(:user) }
  let (:existing_user) { create(:user) }
  let (:signup_url) { '/api/signup' }

  context 'When creating a new user' do
    before do
      post signup_url, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns the user email' do
      expect(json['data']["attributes"]["email"]).to eql(user.email)
    end
  end

  context 'When an email already exists' do
    before do
      post signup_url, params: {
        user: {
          email: existing_user.email,
          password: existing_user.password
        }
      }
    end

    it 'returns 400' do
      expect(response.status).to eq(400)
    end
  end
end

private

def json
  JSON.parse(response.body)
end