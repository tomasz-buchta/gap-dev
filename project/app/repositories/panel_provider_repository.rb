require "dry/monads/result"

class PanelProviderRepository
  include Dry::Monads::Result::Mixin

  def for_country(country_code)
    record =
      PanelProvider
      .joins(:countries)
      .where(countries: { code: country_code })
      .first
    record.nil? ? Failure(:provider_not_found) : Success(record)
  end

  private

  PANEL_PROVIDER_TIMES_A_CODE    = "times_a".freeze
  PANEL_PROVIDER_10_ARRAYS_CODE  = "10_arrays".freeze
  PANEL_PROVIDER_TIMES_HTML_CODE = "times_html".freeze

  def map_provider_to_strategies(provider)

    PANEL_PROVIDERS_CODES = %w[times_a 10_arrays times_html].freeze
    case provider.code
    when PANEL_PROVIDER_TIMES_A_CODE then times_a_pricing_strategy
    when PANEL_PROVIDER_10_ARRAYS_CODE then 10_arrays_prcing_strategy
    when PANEL_PROVIDER_TIMES_HTML_CODE then times_html_pricing_strategy
    end
  end
end
