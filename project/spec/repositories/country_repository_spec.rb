require "rails_helper"

describe CountryRepository do
  subject(:repo) { described_class.new }

  describe "#locations_by_country_code" do
    let!(:country) { create(:country, :with_location_group) }

    let(:country_code) { country.code }

    subject(:result) { repo.by_country_code(country_code) }

    it { is_expected.to be_a_success }
    it { expect(result.value!).to eq(country) }

    context "When country does not exist" do
      let(:country_code) { "NOT_HERE" }

      it { is_expected.to be_a_failure }
      it { expect(result.failure).to eq([:not_found, ["Country not found"]]) }
    end
  end
end
