require "dry/monads/result"

module PricingStrategies
  class TimesHtmlPricingStrategy
    include Dry::Monads::Result::Mixin

    URL = "http://time.com/".freeze

    def call
      response = HTTParty.get(URL)
      if response.success?
        Success(Nokogiri::HTML(response).search("*").count.to_f / 100)
      else
        Failure(:external_error, ["Cannot fetch #{URL}"])
      end
    end
  end
end
