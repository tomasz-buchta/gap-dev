FactoryBot.define do
  factory :panel_provider do
    sequence(:code) { |n| PanelProvider::PANEL_PROVIDERS_CODES[n % 3] }
  end
end
