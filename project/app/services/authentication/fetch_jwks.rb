module Authentication
  class FetchJwks
    def call
      jwks_raw = HTTParty.get(URI(Rails.application.credentials.auth0_jwks_url)).body
      jwks_keys = Array(JSON.parse(jwks_raw)["keys"])
      Hash[
        jwks_keys
        .map do |k|
          [
            k["kid"],
            OpenSSL::X509::Certificate.new(
              Base64.decode64(k["x5c"].first)
            ).public_key
          ]
        end
      ]
    end
  end
end
