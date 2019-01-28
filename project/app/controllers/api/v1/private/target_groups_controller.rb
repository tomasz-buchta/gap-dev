module Api
  module V1
    module Private
      class TargetGroupsController < BaseController
        include AppImport[
          "target_group_repository",
          "serializers.private.target_group_serializer"
        ]

        def show
          result =
            target_group_repository
            .by_country_code(params[:country_code])
            .value_or []
          render json: target_group_serializer.new(result).serialized_json
        end
      end
    end
  end
end
