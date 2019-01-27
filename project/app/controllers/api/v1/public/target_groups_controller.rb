module Api
  module V1
    module Public
      class TargetGroupsController < ApplicationController
        include AppImport["target_group_repository"]

        def show
          result =
            target_group_repository
            .by_country_code(params[:country_code])
            .value_or([])
          render json: serializer.new(result).serialized_json
        end

        private

        def serializer
          ::Public::TargetGroupSerializer
        end
      end
    end
  end
end
