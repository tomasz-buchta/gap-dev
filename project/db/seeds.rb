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

[
  { secret_code: "AAA111", name: "Tenis players" },
  { secret_code: "AAA112", name: "Football players" },
  { secret_code: "AAA113", name: "Hockey players" },
  { secret_code: "AAA114", name: "Archers" },
  { secret_code: "AAA115", name: "Martial arts practitioners" },
  { secret_code: "AAA116", name: "Runners" },
  { secret_code: "AAA117", name: "Volleyball players" }
]

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
