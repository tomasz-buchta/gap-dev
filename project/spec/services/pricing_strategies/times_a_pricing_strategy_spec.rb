require "rails_helper"

describe PricingStrategies::TimesAPricingStrategy do
  describe "#call" do
    subject { described_class.new.call }
    around do |example|
      VCR.use_cassette "times.com" do
        example.run
      end
    end
    it { is_expected.to be_a_success }
    it { expect(subject.value!).to eq(734) }
  end
end
