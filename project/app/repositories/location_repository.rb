require "dry/monads/result"

class LocationRepository
  include Dry::Monads::Result::Mixin

  def locations_by_country_code(country_code)
    Success(
      Location
      .joins(location_group: [:country])
      .where(countries: { code: country_code })
    )
  end
end
