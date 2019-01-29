require "dry/monads/result"
require "dry/monads/do"

class TargetGroupRepository
  include Dry::Monads::Result::Mixin
  include Dry::Monads::Do.for(:by_country_code)

  include AppImport["country_repository"]

  def by_country_code(country_code)
    country = yield country_repository.by_country_code(country_code)
    Success(country.target_groups.joins(:self_and_descendants))
  end
end
