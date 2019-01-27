module Api
  module V1
    module Private
      class TargetGroupsController < ApplicationController
        include AppImport["target_group_repository"]

        def show
          result =
            target_group_repository
            .by_country_code(params[:country_code])
            .value_or []
          render json: result
        end
      end
    end
  end
end
