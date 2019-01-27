module Api
  module V1
    module Private
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
          ::Private::LocationSerializer
        end
      end
    end
  end
end
