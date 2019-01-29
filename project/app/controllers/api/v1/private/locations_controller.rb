module Api
  module V1
    module Private
      class LocationsController < BasePrivateController
        include AppImport[
          "location_repository",
          "result_matcher",
          "serializers.location_serializer"
        ]

        def show
          result =
            location_repository
            .locations_by_country_code(params[:country_code])

          result_matcher.call(result) do |m|
            m.success do |locations|
              render json: location_serializer.new(locations, params: { private: true }).serialized_json
            end
            m.failure :not_found do |message|
              render status: :not_found, json: { message: "Not found", errors: message }
            end
            m.failure do
              render status: :internal_server_error, json: { message: "Something went wrong", errors: message }
            end
          end
        end
      end
    end
  end
end
