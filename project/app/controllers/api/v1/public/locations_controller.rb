module Api
  module V1
    module Public
      class LocationsController < ApplicationController
        include AppImport["location_repository"]

        def show
          result =
            location_repository
            .locations_by_country_code(params[:country_code])
            .value_or []
          render json: serializer.new(result).serialized_json
        end

        private

        def serializer
          ::Public::LocationSerializer
        end
      end
    end
  end
end
