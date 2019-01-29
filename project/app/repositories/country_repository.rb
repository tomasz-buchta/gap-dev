require "dry/monads/result"

class CountryRepository
  include Dry::Monads::Result::Mixin

  def by_country_code(country_code)
    record =
      Country
      .joins(:panel_provider)
      .find_by(code: country_code)
    record.nil? ? Failure([:not_found, ["Country not found"]]) : Success(record)
  end
end
