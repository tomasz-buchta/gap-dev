module Api
  module V1
    module Private
      class LocationsController < BaseController
        before_action :authenticate!

        include AppImport[
          "location_repository",
          "serializers.private.location_serializer"
        ]

        def show
          result =
            location_repository
            .locations_by_country_code(params[:country_code])
            .value_or []
          render json: location_serializer.new(result).serialized_json
        end
      end
    end
  end
end
