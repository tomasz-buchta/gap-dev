require "rails_helper"

describe ValidateEvaluateTargetParams do
  describe "#call" do
    subject { described_class.new.call(params) }
    let(:params) do
      {
        country_code: "PL",
        target_group_id: 1,
        locations: [
          { id: 123, panel_size: 200 }
        ]
      }
    end

    it { is_expected.to be_a(Dry::Monads::Result) }
    it { is_expected.to be_a_success }
    context "with invalid params" do
      let(:params) { {} }
      it { is_expected.to be_a_failure }
      it "contains error messages" do
        expect(subject.failure).to eq(
          country_code: ["is missing"],
          locations: ["is missing"],
          target_group_id: ["is missing"]
        )
      end
    end
  end
end
