module Authentication
  class VerifyJSONWebToken
    include AppImport["authentication.fetch_jwks"]
    def call(token)
      JWT.decode(token, nil,
                 true, # Verify the signature of this token
                 algorithm: "RS256",
                 iss: Rails.application.credentials.auth0_iss,
                 verify_iss: true,
                 # auth0_api_audience is the identifier for the API set up in the Auth0 dashboard
                 aud: Rails.application.credentials.auth0_aud,
                 verify_aud: true) do |header|
                   fetch_jwks.call[header["kid"]]
                 end
    end
  end
end
