module Api
  module V1
    module Private
      class TargetGroupsController < BasePrivateController
        include CommonResponseHandler

        include AppImport[
          "target_group_repository",
          "result_matcher",
          "serializers.target_group_serializer"
        ]

        def show
          result =
            target_group_repository
            .by_country_code(params[:country_code])

          match_result_to_response(result, result_matcher) do |target_groups|
            render json: target_group_serializer
              .new(target_groups, params: { private: true })
              .serialized_json
          end
        end
      end
    end
  end
end
