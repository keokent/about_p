require 'bcrypt'

class APIKey < Settingslogic
  source "#{Rails.root}/config/hashed_api_key.yml"

  def self.authenticate(api_key)
    BCrypt::Password.new(self[Rails.env]) == api_key
  end
end
