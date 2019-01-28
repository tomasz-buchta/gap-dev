require "dry/monads/result"

class PanelProviderRepository
  include Dry::Monads::Result::Mixin

  def for_country_code(country_code)
    record =
      PanelProvider
      .joins(:countries)
      .where(countries: { code: country_code })
      .first
    record.nil? ? Failure(type: :not_found, errors: ["Provider not found"]) : Success(record)
  end
end
