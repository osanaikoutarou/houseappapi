require 'jwt'
require 'base64'

module AuthToken
  # Default Algorithms: HMAC (HS256)
  CRYPTO_ALGORITHMS = 'HS256'

  def self.sign(payload)
    # Set expiration to 30 days
    payload['exp'] = 30.days.from_now.to_i
    payload['now'] = Time.now.to_i
    Base64.urlsafe_encode64(JWT.encode(payload, Rails.application.secrets.secret_key_base, CRYPTO_ALGORITHMS))
  end

  def self.verify(token)
    JWT.decode(Base64.urlsafe_decode64(token), Rails.application.secrets.secret_key_base, true, algorithm: CRYPTO_ALGORITHMS)
  rescue
    false
  end

  def self.payload(token)
    JWT.decode(Base64.urlsafe_decode64(token), Rails.application.secrets.secret_key_base, true, algorithm: CRYPTO_ALGORITHMS)
  rescue
    nil
  end
end
