require "dry/monads/result"

class TargetGroupRepository
  include Dry::Monads::Result::Mixin
  # Warning this will execute 1 + n queries where n = root TargetGroups of country
  # FIXME: Remove n + 1 queries problem
  # TODO: Return tree like structure from here
  def by_country_code(country_code)
    Success(
      TargetGroup
      .joins(:countries)
      .where(countries: { code: country_code })
      .collect(&:self_and_descendants)
      .flatten
    )
  end
end
