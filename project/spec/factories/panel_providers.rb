FactoryBot.define do
  factory :panel_provider do
    sequence(:code) { |n| "code-#{n}" }
  end
end
