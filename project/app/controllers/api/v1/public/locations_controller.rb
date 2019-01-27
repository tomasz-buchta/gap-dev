module Api
  module V1
    module Public
      class LocationsController < ApplicationController
        include AppImport[
          "location_repository",
          "serializers.public.location_serializer"
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
