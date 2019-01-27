class ValidateEvaluateTargetParams
  Dry::Validation.load_extensions(:monads)

  SCHEMA = Dry::Validation.Params do
    required(:country_code).filled
    required(:target_group_id).filled
    required(:locations).each do
      schema do
        required(:id).filled
        required(:panel_size).filled
      end
    end
  end

  def call(input)
    SCHEMA.call(input).to_monad
  end
end
