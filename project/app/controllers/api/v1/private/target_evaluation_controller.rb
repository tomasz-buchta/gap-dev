require "dry/matcher/result_matcher"

module Api
  module V1
    module Private
      class TargetEvaluationController < BaseController
        include AppImport["evaluate_target"]

        def create
          Dry::Matcher::ResultMatcher.call(evaluate_target.call(params.to_unsafe_hash)) do |m|
            m.success do |result|
              render json: result
            end
            m.failure :validate do |messages|
              render status: 400, json: { message: "Invalid params", errors: messages }
            end
            m.failure :not_found do |message|
              render status: 500, json: { message: "Something went wrong", errors: message }
            end
          end
        end
      end
    end
  end
end
