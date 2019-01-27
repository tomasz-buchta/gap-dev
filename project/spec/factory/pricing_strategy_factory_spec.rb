require "rails_helper"

describe PricingStrategyFactory do
  describe "#from_provider" do
    let(:provider) { build(:panel_provider, code: "times_a") }
    subject { PricingStrategyFactory.new.from_provider(provider) }
    before do
      AppContainer.stub(
        "pricing_strategies.times_a_pricing_strategy",
        instance_double(PricingStrategies::TimesAPricingStrategy)
      )
      AppContainer.stub(
        "pricing_strategies.times_html_pricing_strategy",
        instance_double(PricingStrategies::TimesHtmlPricingStrategy)
      )
      AppContainer.stub(
        "pricing_strategies.ten_arrays_pricing_strategy",
        instance_double(PricingStrategies::TenArraysPricingStrategy)
      )
    end

    it { is_expected.to be_a_success }

    context "with unknown provider" do
      let(:provider) { build(:panel_provider, code: "the_duck") }

      it { is_expected.to be_a_failure }
    end
  end
end
