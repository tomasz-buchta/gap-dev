require "dry/monads/result"
require "dry/monads/do"

class TargetGroupRepository
  include Dry::Monads::Result::Mixin
  include Dry::Monads::Do.for(:by_country_code)

  include AppImport["country_repository"]

  # Warning this will execute 1 + n queries where n = root TargetGroups of country
  # FIXME: Remove n + 1 queries problem
  # TODO: Return tree like structure from here
  def by_country_code(country_code)
    country = yield country_repository.by_country_code(country_code)
    Success(country.target_groups.collect(&:self_and_descendants).flatten)
  end
end
