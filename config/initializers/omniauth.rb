Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, GithubTokens.client_id, GithubTokens.secret
end
