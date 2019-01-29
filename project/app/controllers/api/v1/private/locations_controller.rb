module Api
  module V1
    module Private
      class LocationsController < BasePrivateController
        include CommonResponseHandler

        include AppImport[
          "location_repository",
          "result_matcher",
          "serializers.location_serializer"
        ]

        def show
          result =
            location_repository
            .locations_by_country_code(params[:country_code])

          match_result_to_response(result, result_matcher) do |locations|
            render json: location_serializer
              .new(locations, params: { private: true })
              .serialized_json
          end
        end
      end
    end
  end
end
