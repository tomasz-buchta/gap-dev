require "rails_helper"

describe LocationRepository do
  subject(:repo) { described_class.new }

  describe "#locations_by_country_code" do
    let!(:country) { create(:country, :with_location_group) }
    let!(:location) { create(:location, location_group: country.location_groups.last) }

    let(:country_code) { country.code }

    subject(:locations) { repo.locations_by_country_code(country_code) }

    it { is_expected.to be_a_success }
    it { expect(locations.value!).to eq([location]) }

    context "When country does not exist" do
      let(:country_code) { "NOT_HERE" }

      it { is_expected.to be_a_success }
      it { expect(locations.value!).to be_empty }
    end
  end
end
