require "dry/monads/result"

module PricingStrategies
  class TimesAPricingStrategy
    include Dry::Monads::Result::Mixin

    URL = "http://time.com/".freeze
    CHARACTER_TO_COUNT = "a".freeze

    def call
      response = HTTParty.get(URL)
      if response.success?
        Success(Nokogiri::HTML(response).text.count(CHARACTER_TO_COUNT).to_f / 100)
      else
        Failure(:external_error, ["Cannot fetch #{URL}"])
      end
    end
  end
end
