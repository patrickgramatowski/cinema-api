require "devise/jwt/test_helpers"

module RequestHelper
  def setup_request(user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
  end

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
end

RSpec.configure do |config|
  config.include RequestHelper, type: :request
end