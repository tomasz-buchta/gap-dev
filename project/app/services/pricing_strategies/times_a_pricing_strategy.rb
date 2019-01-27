require "dry/monads/result"

module PricingStrategies
  class TimesAPricingStrategy
    include Dry::Monads::Result::Mixin

    URL = "http://time.com/".freeze
    CHARACTER_TO_COUNT = "a".freeze

    def call
      response = HTTParty.get(URL)
      if response.success?
        Success(Nokogiri::HTML(response).text.count(CHARACTER_TO_COUNT))
      else
        Failure("Cannot fetch #{URL}")
      end
    end
  end
end
