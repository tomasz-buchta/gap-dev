module Api
  module V1
    module Private
      class TargetEvaluationController < ApplicationController
        include AppImport["evaluate_target"]

        def create
          result = evaluate_target.call(params.to_unsafe_hash)
          if result.success?
            render json: result.value!
          else
            render json: { error: "Something went wrong", message: result.failure }
          end
        end
      end
    end
  end
end
