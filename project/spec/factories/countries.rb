FactoryBot.define do
  factory :country do
    code { ("A".."Z").to_a.sample(4).join } # random 4 letter code
    panel_provider

    trait :with_location_group do
      after(:create) do |country, _evaluator|
        create_list(:location_group, 2, country: country, panel_provider: country.panel_provider)
      end
    end
  end
end
