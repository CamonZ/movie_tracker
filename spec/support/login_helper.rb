module LoginHelper
  def token_for_user(user)
    Doorkeeper::AccessToken.find_or_create_for(
      nil,
      user.id,
      Doorkeeper.configuration.default_scopes,
      Doorkeeper.configuration.access_token_expires_in,
      false
    )
  end
end
