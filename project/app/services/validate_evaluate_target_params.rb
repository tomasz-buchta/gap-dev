class ValidateEvaluateTargetParams
  Dry::Validation.load_extensions(:monads)

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
    SCHEMA.call(input).to_monad
  end
end
