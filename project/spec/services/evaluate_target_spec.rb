require "rails_helper"
require "dry/monads/result"

describe EvaluateTarget do
  include Dry::Monads::Result::Mixin

  let(:params) do
    {
      country_code: "PL",
      target_group_id: 1,
      locations: [
        { id: 123, panel_size: 200 }
      ]
    }
  end
  let(:panel_provider) { build(:panel_provider, code: "times_a") }
  before do
    AppContainer.stub(
      "validate_evaluate_target_params",
      double(call: Success(params))
    )
    AppContainer.stub(
      "panel_provider_repository",
      instance_double(PanelProviderRepository, for_country_code: Success(panel_provider))
    )
    AppContainer.stub(
      "pricing_strategy_factory",
      instance_double(
        PricingStrategyFactory,
        from_provider: Success(instance_double(TimesAPricingStrategy, call: Success(54.33)))
      )
    )
  end
  let!(:country) { create(:country) }
  subject { described_class.new.call(params) }
  describe "#call" do
    it { is_expected.to be_a_success }
    it { expect(subject.value!).to eq [{ id: 123, panel_size: 200, price: 200 * 54.33 }] }
  end
end
