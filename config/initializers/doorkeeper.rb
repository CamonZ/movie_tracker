Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (needs plugins)
  orm :active_record

  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_authenticator do
    warden.authenticate!(scope: :user)
  end

  resource_owner_from_credentials do |routes|
    u = User.find_for_database_authentication(email: params[:email])
    u if u && u.valid_password?(params[:password])
  end

  access_token_expires_in 24.hours

   default_scopes  :public
   optional_scopes :owner

  grant_flows %w(password)

  skip_authorization do |resource_owner, client|
    true
  end
end
