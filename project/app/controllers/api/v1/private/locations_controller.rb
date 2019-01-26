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
          render json: result
        end
      end
    end
  end
end
