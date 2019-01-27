class PricingStrategyFactory
  include Dry::Monads::Result::Mixin

  PANEL_PROVIDER_TIMES_A_CODE    = "times_a".freeze
  PANEL_PROVIDER_10_ARRAYS_CODE  = "10_arrays".freeze
  PANEL_PROVIDER_TIMES_HTML_CODE = "times_html".freeze

  def map_provider_to_strategies(provider)
    case provider.code
    when PANEL_PROVIDER_TIMES_A_CODE
      times_a_pricing_strategy
    when PANEL_PROVIDER_10_ARRAYS_CODE
      ten_arrays_pricing_strategy
    when PANEL_PROVIDER_TIMES_HTML_CODE
      times_html_pricing_strategy
    else
      Failure(:unknown_pricing_strategy)
    end
  end
end
