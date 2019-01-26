FactoryBot.define do
  factory :location do
    location_group
    name { "New York" }
    external_id { SecureRandom.uuid }
    secret_code { SecureRandom.hex(64) }
  end
end
