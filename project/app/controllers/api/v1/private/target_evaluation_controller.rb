class Api::V1::Private::TargetEvaluationController < ApplicationController
  def create
    validate_params(input)

  end

  private

  def validate_params(input)
    schema = Dry::Validation.Params do
      required(:country_code)
      required(:target_group_id)
      required(:location).schema do
        required(:id)
        required(:panel_size)
      end
    end
  end
end
