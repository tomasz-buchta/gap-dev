module Api
  module V1
    module Private
      class TargetGroupsController < BasePrivateController
        include AppImport[
          "target_group_repository",
          "result_matcher",
          "serializers.private.target_group_serializer"
        ]

        def show
          result =
            target_group_repository
            .by_country_code(params[:country_code])

          result_matcher.call(result) do |m|
            m.success do |target_groups|
              render json: target_group_serializer.new(target_groups).serialized_json
            end
            m.failure :not_found do |message|
              render status: :not_found, json: { message: "Not found", errors: message }
            end
            m.failure do
              render status: :internal_server_error, json: { message: "Something went wrong", errors: message }
            end
          end
        end
      end
    end
  end
end
