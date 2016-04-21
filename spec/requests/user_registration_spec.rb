require 'rails_helper'

describe "User::RegistrationsController", type: :request do
  let(:new_user_attributes) do
    { email: 'test_user@test.com', password: '12345678', password_confirmation: '12345678' }
  end

  it "registers a new user" do
    post "/users/", params: { user: new_user_attributes }

    expect(response).to be_successful
    expect(response).to be_a_serialized(:user)
  end
end
