require 'rails_helper'

describe "Doorkeeper::Tokens", type: :request do
  let!(:user) { User.create(email: 'test_user@test.com', password: '12345678', password_confirmation: '12345678') }
  let(:login_params) { { grant_type: 'password', email: 'test_user@test.com', password: '12345678' } }
  it "logins the user and returns the access token" do
    post "/oauth/token", params: login_params

    expect(parsed_response).to have_key(:access_token)
    expect(parsed_response[:token_type]).to eql('bearer')
  end
end
