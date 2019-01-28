module Authentication
  class VerifyJSONWebToken
    include AppImport["authentication.fetch_jwks"]
    def call(token)
      JWT.decode(token, nil,
                 true, # Verify the signature of this token
                 algorithm: "RS256",
                 iss: "https://gap-dev-test.eu.auth0.com/",
                 verify_iss: true,
                 # auth0_api_audience is the identifier for the API set up in the Auth0 dashboard
                 aud: "http://lvh.me:3000",
                 verify_aud: true) do |header|
                   fetch_jwks.call[header["kid"]]
                 end
    end
  end
end
