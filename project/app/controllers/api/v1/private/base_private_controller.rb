module Api
  module V1
    module Private
      class BasePrivateController < ApplicationController
        include AppImport["authentication.verify_json_web_token"]

        before_action :authenticate!

        private

        def authenticate!
          supplied_token = String(request.env["HTTP_AUTHORIZATION"]).slice(7..-1)

          @auth_payload, @auth_header = verify_json_web_token.call(supplied_token)
        rescue JWT::DecodeError => e
          raise AuthorizationException, e.message
        end
      end
    end
  end
end
