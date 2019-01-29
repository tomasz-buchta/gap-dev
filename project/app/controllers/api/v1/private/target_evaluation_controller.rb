module Api
  module V1
    module Private
      class TargetEvaluationController < BasePrivateController
        include AppImport[
          "evaluate_target",
          "result_matcher"
        ]

        def create
          result_matcher.call(evaluate_target.call(params.to_unsafe_hash)) do |m|
            m.success do |result|
              render json: result
            end
            m.failure :validation_failed do |errors|
              render status: :bad_request, json: { message: "Invalid params", errors: errors }
            end
            m.failure :not_found do |message|
              render status: :not_found, json: { message: "Not found", errors: message }
            end
            m.failure do |message|
              render status: :internal_server_error, json: { message: "Something went wrong", errors: message }
            end
          end
        end
      end
    end
  end
end
