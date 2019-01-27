require "dry/monads/result"
require "dry/monads/do"

class EvaluateTarget
  include Dry::Monads::Result::Mixin
  include Dry::Monads::Do.for(:call)

  include AppImport["validate_evaluate_target_params", "panel_provider_repository"]

  def call(input)
    valid_params = yield validate_evaluate_target_params.call(input)
    panel_provider = panel_provider_repository.for_country_code(valid_params[:country_code])
  end
end
