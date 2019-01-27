require "rails_helper"

describe TargetGroupRepository do
  subject(:repo) { described_class.new }

  describe "#by_country_code" do
    let!(:countries_target_group) { create(:countries_target_group) }

    let(:country_code) { countries_target_group.country.code }

    subject(:target_groups) { repo.by_country_code(country_code) }

    it { is_expected.to be_a_success }
    it { expect(target_groups.value!.first).to eq(countries_target_group.target_group) }

    context "When country does not exist" do
      let(:country_code) { "NOT_HERE" }

      it { is_expected.to be_a_success }
      it { expect(target_groups.value!).to be_empty }
    end
  end
end
