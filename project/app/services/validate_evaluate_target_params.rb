class ValidateEvaluateTargetParams
  include Dry::Monads::Result::Mixin

  SCHEMA = Dry::Validation.Params do
    required(:country_code).filled(:str?)
    required(:target_group_id).filled(:int?)
    required(:locations).each do
      schema do
        required(:id).filled(:int?)
        required(:panel_size).filled(:int?)
      end
    end
  end

  def call(input)
    result = SCHEMA.call(input)
    if result.success?
      Success(result)
    else
      Failure(step: :validate, errors: result.errors)
    end
  end
end
