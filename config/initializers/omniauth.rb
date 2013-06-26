Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env == 'test'
    provider :github, "12345", "12345" # dummy token, secret
  else
    provider :github, GithubTokens.client_id, GithubTokens.secret
  end
end
