require "dry/monads/result"

module PricingStrategies
  class TenArraysPricingStrategy
    include Dry::Monads::Result::Mixin

    URL = "http://openlibrary.org/search.json?q=the+lord+of+the+rings".freeze

    def call
      response = HTTParty.get(URL)
      if response.success?
        parsed_content = JSON(response)
        Success(arrays_count(parsed_content).to_f / 10)
      else
        Failure("Failed to fetch #{URL}")
      end
    end

    private

    def arrays_count(json)
      json.sum do |element|
        count = 0

        if element.is_a?(Array)
          count = 1 if element.count > 10
          count += arrays_count(element)
        elsif element.is_a?(Hash)
          count += arrays_count(element.values)
        end

        count
      end
    end
  end
end
