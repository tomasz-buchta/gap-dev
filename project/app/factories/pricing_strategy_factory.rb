require "dry/monads/result"

class PricingStrategyFactory
  include Dry::Monads::Result::Mixin

  include AppImport[
    "pricing_strategies.times_a_pricing_strategy",
    "pricing_strategies.times_html_pricing_strategy",
    "pricing_strategies.ten_arrays_pricing_strategy",
  ]
  include Dry::Monads::Result::Mixin

  PANEL_PROVIDER_TIMES_A_CODE    = "times_a".freeze
  PANEL_PROVIDER_10_ARRAYS_CODE  = "10_arrays".freeze
  PANEL_PROVIDER_TIMES_HTML_CODE = "times_html".freeze

  def from_provider(provider)
    case provider.code
    when PANEL_PROVIDER_TIMES_A_CODE
      Success(times_a_pricing_strategy)
    when PANEL_PROVIDER_10_ARRAYS_CODE
      Success(ten_arrays_pricing_strategy)
    when PANEL_PROVIDER_TIMES_HTML_CODE
      Success(times_html_pricing_strategy)
    else
      Failure(:unknown_pricing_strategy)
    end
  end
end
