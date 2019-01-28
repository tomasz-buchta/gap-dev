module Api
  module V1
    module Private
      class TargetEvaluationController < BaseController
        include AppImport["evaluate_target"]

        def create
          result = evaluate_target.call(params.to_unsafe_hash)
          if result.success?
            render json: result.value!
          else
            render json: { message: "Something went wrong", errors: result.failure }
          end
        end
      end
    end
  end
end
