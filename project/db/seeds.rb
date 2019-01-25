PANEL_PROVIDERS_CODES = %w[times_a 10_arrays times_html].freeze

COUNTRIES = [
  { code: "PL", panel_provider_code: "times_a" },
  { code: "US", panel_provider_code: "10_arrays" },
  { code: "UK", panel_provider_code: "times_html" }
].freeze

LOCATIONS = [
  { name: "New York" },
  { name: "Los Angeles" },
  { name: "Chicago" },
  { name: "Houston" },
  { name: "Philadelphia" },
  { name: "Phoenix" },
  { name: "San Antonio" },
  { name: "San Diego" },
  { name: "Dallas" },
  { name: "San Jose" },
  { name: "Austin" },
  { name: "Jacksonville" },
  { name: "San Francisco" },
  { name: "Indianapolis" },
  { name: "Columbus" },
  { name: "Fort Worth" },
  { name: "Charlotte" },
  { name: "Detroit" },
  { name: "El Paso" },
  { name: "Seattle" }
].freeze

PANEL_PROVIDERS_CODES.each { |panel_provider_code| PanelProvider.create!(code: panel_provider_code) }

panel_providers = PanelProvider.all.to_a << PanelProvider.last

COUNTRIES.each do |country|
  Country.create!(
    code: country.fetch(:code),
    panel_provider: PanelProvider.find_by!(code: country.fetch(:panel_provider_code))
  )
end

countries = Country.all.to_a << Country.last

LOCATIONS.each do |location|
  Location.create!(
    name: location.fetch(:name),
    external_id: SecureRandom.uuid,
    secret_code: SecureRandom.hex(64)
  )
end

LOCATION_GROUPS = [
  { name: "The West" },
  { name: "The South" },
  { name: "The Midwest" },
  { name: "The Norht-East" }
].freeze

panel_providers
  .zip(countries, LOCATION_GROUPS) do |panel_provider, country, location_group|
  LocationGroup.create!(
    panel_provider: panel_provider,
    country: country,
    name: location_group[:name]
  )
end

TARGET_GROUPS = [
  { name: "Tenis players" },
  { name: "Football players" },
  { name: "Hockey players" },
  { name: "Archers" },
  { name: "Martial arts practitioners" },
  { name: "Runners" },
  { name: "Volleyball players" }
].freeze

# TODO: Provide more meaningful names
# I'm too lazy to provide some meaningful names right now

(1..4).to_a.zip(countries, panel_providers) do |i, country, panel_provider|
  TargetGroup.create!(
    panel_provider: panel_provider,
    countries: [country],
    name: "a#{i}",
    external_id: SecureRandom.uuid,
    secret_code: SecureRandom.hex(64)
  )
end
