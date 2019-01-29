require "rails_helper"

describe TargetGroupRepository do
  include Dry::Monads::Result::Mixin
  subject(:repo) { described_class.new }

  before do
    AppContainer.stub(
      "country_repository",
      instance_double(CountryRepository, by_country_code: Success(countries_target_group.country))
    )
  end

  describe "#by_country_code" do
    let!(:countries_target_group) { create(:countries_target_group) }

    let(:country_code) { countries_target_group.country.code }

    subject(:target_groups) { repo.by_country_code(country_code) }

    it { is_expected.to be_a_success }
    it { expect(target_groups.value!.first).to eq(countries_target_group.target_group) }

    context "When country does not exist" do
      before do
        AppContainer.stub(
          "country_repository",
          instance_double(
            CountryRepository,
            by_country_code: Failure([:not_found, ["Country not found"]])
          )
        )
      end
      let(:country_code) { "NOT_HERE" }

      it { is_expected.to be_a_failure }
      it { expect(target_groups.failure).to eq([:not_found, ["Country not found"]]) }
    end
  end
end
