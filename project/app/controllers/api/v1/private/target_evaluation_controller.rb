module Api
  module V1
    module Private
      class TargetEvaluationController < BasePrivateController
        include CommonResponseHandler

        include AppImport[
          "evaluate_target",
          "result_matcher"
        ]

        def create
          result = evaluate_target.call(params.to_unsafe_hash)
          match_result_to_response(result, result_matcher) do |evaluation|
            render json: evaluation
          end
        end
      end
    end
  end
end
