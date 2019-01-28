module Api
  module V1
    module Private
      class BaseController < ApplicationController
        def authenticate!
          supplied_token = String(request.env["HTTP_AUTHORIZATION"]).slice(7..-1)

          @auth_payload, @auth_header = JsonWebToken.verify(supplied_token)
        rescue JWT::DecodeError => e
          raise AuthorizationException, e.message
        end
      end
    end
  end
end
