module Api
  module V1
    module Public
      class TargetGroupsController < ApplicationController
        include AppImport[
          "target_group_repository",
          "serializers.public.target_group_serializer"
        ]

        def show
          result =
            target_group_repository
            .by_country_code(params[:country_code])
            .value_or([])
          render json: target_group_serializer.new(result).serialized_json
        end
      end
    end
  end
end
