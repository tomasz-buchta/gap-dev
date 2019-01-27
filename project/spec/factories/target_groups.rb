FactoryBot.define do
  factory :target_group do
    name { "MyString" }
    external_id { SecureRandom.uuid }
    parent { nil }
    sequence(:secret_code) { |n| "code-#{n}" }
    panel_provider

    trait :with_parent do
      association :parent, factory: :target_group
    end
  end
end
