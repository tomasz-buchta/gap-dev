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
        expect(subject.failure[1]).to eq(
          country_code: ["is missing"],
          locations: ["is missing"],
          target_group_id: ["is missing"]
        )
      end
      context "invalid param types" do
        let(:params) do
          {
            country_code: 1,
            target_group_id: "1",
            locations: [
              { id: "duck", panel_size: "duck_xxl" }
            ]
          }
        end
        it "contains error messages" do
          expect(subject.failure[1]).to eq(
            country_code: ["must be a string"],
            locations: { 0 => { id: ["must be an integer"], panel_size: ["must be an integer"] } }
          )
        end
      end
    end
  end
end
