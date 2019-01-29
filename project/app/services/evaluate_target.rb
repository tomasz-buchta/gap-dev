require "dry/monads/result"
require "dry/monads/do"

class EvaluateTarget
  include Dry::Monads::Result::Mixin
  include Dry::Monads::Do.for(:call)

  include AppImport[
    "validate_evaluate_target_params",
    "country_repository",
    "pricing_strategy_factory"
  ]

  def call(input)
    valid_params = yield validate_evaluate_target_params.call(input)
    country = yield country_repository.by_country_code(valid_params[:country_code])
    pricing_strategy = yield pricing_strategy_factory.from_provider(country.panel_provider)
    unit_price = yield pricing_strategy.call
    Success(calculate_location_prices(valid_params[:locations], unit_price))
  end

  private

  def calculate_location_prices(locations, unit_price)
    locations.map do |location|
      location[:price] = location[:panel_size] * unit_price
      location
    end
  end
end
