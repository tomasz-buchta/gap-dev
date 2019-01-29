require "dry/matcher/result_matcher"

module Api
  module V1
    module Private
      class TargetEvaluationController < BaseController
        include AppImport["evaluate_target"]

        def create
          matcher.call(evaluate_target.call(params.to_unsafe_hash)) do |m|
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

        private

        def matcher
          Dry::Matcher.new(
            success: Dry::Matcher::Case.new(
              match: ->(result) { result.success? },
              resolve: ->(result) { result.value! }
            ),
            failure: Dry::Matcher::Case.new(
              match: ->(result, failure_type = nil) {
                if failure_type
                  result.failure? && result.failure.first == failure_type
                else
                  result.failure?
                end
              },
              resolve: ->(result) { result.failure.last }
            )
          )
        end
      end
    end
  end
end
