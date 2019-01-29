ResultMatcher = Dry::Matcher.new(
  success: Dry::Matcher::Case.new(
    match: ->(result) { result.success? },
    resolve: ->(result) { result.value! }
  ),
  failure: Dry::Matcher::Case.new(
    match: ->(result, failure_type = nil) {
      if failure_type
        result.failure? && result.failure.first == failure_type
      else
        result.failure?
      end
    },
    resolve: ->(result) { result.failure.last }
  )
)
